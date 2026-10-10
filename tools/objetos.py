#!/usr/bin/env python3
"""Los objetos de caracteres de Nemesis 2, dibujados desde sus tablas.

Hay 8 fichas de 16 bytes en 0xE500. Las pone p02:87F8 al llegar el scroll a
cada entrada de la lista de la fase (0xBA12[fase], banco 12; la lee
p02:8879): 3 bytes por objeto, [x bajo][y & 0xF8 | x alto][marcas], con la
clase en los bits 4-0 de las marcas (IX+00), los bits 6-5 en IX+0B y el bit 7
para la segunda vuelta (0xE20A). La lista acaba en 0xFFFF, que nunca llega.

La clase elige la rutina de arranque (p02:8829, tabla 0x882C) y esa rutina
pone la forma (IX+07), el ancho (IX+09) y las filas (IX+0A). p01:6017 copia
la forma 0xB661[IX+07] a la tabla de nombres de la RAM (0xED00, p00:5C92:
fila y / 8, columna x / 8), y el VDP la saca con los caracteres de la fase:
el tercio de cada fila es el de la pantalla. Las clases 3 y 4 y las 11-13 no
usan 0xB661 (p01:6000 se las salta): se pintan solas.

Uso: objetos.py <directorio>   (un PNG por clase y fase)
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import bloques as B      # noqa: E402
import dibuja as D       # noqa: E402
import vram as V         # noqa: E402

# (clase, ancho, filas, formas, rutina que las fija)
FAMILIAS = [
    (1, 5, 6, range(0, 16), "p03:B719 pone 0 u 8; p03:B5D2 7 o 15"),
    (5, 4, 5, range(16, 19), "p03:BA13 pone 0x10; p03:B9A6 0x11, p03:B9BE 0x12"),
    (6, 4, 4, [19], "p03:BB90 pone 0x13"),
    (7, 8, 6, range(31, 47), "p03:A119 pone 0x1F o 0x27; p03:A2A5 llega a 0x26 o 0x2E"),
    (9, 6, 3, range(21, 29), "p03:B448 pone 0x15 + 3 x IX+0B"),
    (10, 4, 3, {7: [29, 30], "*": [56, 57]}, "p03:B74D pone 0x1D (fase 7) o 0x38, +1 con IX+0B"),
    (14, 2, 2, range(47, 51), "p11:BE49 pone 0x2F; p11:BE8E sube; p11:BEE1 0x32"),
    (16, 4, 3, list(range(58, 72)) + [51, 52],
     "p11:BADC pone 0x3A (+7 con IX+0B); p11:BC07 0x33 + IX+0F"),
]


def lista_de_la_fase(fase):
    """[(clase, x, y, IX+0B, segunda_vuelta)] de 0xBA12[fase]."""
    v = B.Ventana((1, 2, 12))
    a = v.w(0xBA12 + 2 * fase)
    out = []
    while v.w(a) != 0xFFFF:
        e, b, c = v(a), v(a + 1), v(a + 2)
        out.append((c & 0x1F, (b & 7) * 256 + e, b & 0xF8, (c >> 5) & 3, bool(c & 0x80)))
        a += 3
    return out


def forma(n, ancho, filas):
    v = B.Ventana((13, 14, 15))
    a = v.w(0xB661 + 2 * n)
    return [[v(a + ancho * f + c) for c in range(ancho)] for f in range(filas)]


def pinta_forma(img, x0, y0, filas, fila_pantalla, vram):
    px = img.load()
    for f, fila in enumerate(filas):
        tercio = ((fila_pantalla + f) // 8) % 3
        for c, ch in enumerate(fila):
            base = tercio * 0x800 + ch * 8
            for y in range(8):
                dib = vram[V.DIBUJOS + base + y]
                col = vram[V.COLORES + base + y]
                tinta, fondo = D.PALETA[col >> 4], D.PALETA[col & 0x0F]
                for x in range(8):
                    px[x0 + c * 8 + x, y0 + f * 8 + y] = tinta if dib & (0x80 >> x) else fondo


def hoja(clase, fase, ancho, filas, formas, fila_pantalla, escala=3):
    from PIL import Image
    vram = V.de_la_fase(fase)
    sep = 4
    w = len(formas) * (ancho * 8 + sep) + sep
    h = filas * 8 + 2 * sep
    img = Image.new("RGB", (w, h), (40, 40, 40))
    for k, n in enumerate(formas):
        pinta_forma(img, sep + k * (ancho * 8 + sep), sep, forma(n, ancho, filas),
                    fila_pantalla, vram)
    return img.resize((w * escala, h * escala), Image.NEAREST)


# ------------------------------------------------------------------ jefes
#
# Al acabar el scroll, p01:7A81 pone el tipo de jefe en 0xE340 (1-5) y
# p01:6790 llama a su rutina (tabla 0x67AF, banco 11). Cada tipo arranca con
# una ficha de 10 bytes copiada a 0xEA00: [tipo][..][..][y 16 bits][x 16 bits]
# [cuerpo][barrera][nucleo]; los tres ultimos son numeros de ficha de 0xBB01
# (banco 9), y cada ficha es [filas][columnas][caracteres] (p01:6816). p01:67CE
# las pinta en ese orden con p00:5327 (la tabla de nombres de la RAM), cada
# una donde la deja p11:A9F3: la barrera dy, dx mas abajo y a la derecha del
# cuerpo, y el nucleo, dx2 a la derecha de la barrera. Los tipos 1 a 4 llaman
# antes a p00:4B20, que carga los caracteres de 0x556F y 0x559A; el tipo 5 (dos
# naves a la vez, 0xEA00 y 0xEA20, p11:AFBC) a p00:4C84, con 0xB3AF y 0xB3BC.
# Los golpes: p02:91F2 resta uno a IX+12 y el jefe cae al pasar de 0 (+1).
JEFES = [
    # (tipo, ficha, fases, cuerpo, barrera, nucleo, dy, dx, dx2, IX+12, cita)
    (1, 0xA900, [1], 0x10, 0x00, 0x14, 0x20, 0x10, 0x28, 0x11, "p11:A8D1, p11:AA20"),
    (2, 0xAC49, [4, 5], 0x11, 0x09, 0x14, 0x28, 0x30, 0x20, 0x22, "p11:AC39, p11:AC88"),
    (3, 0xAE58, [7], 0x12, 0x09, 0x14, 0x38, 0x18, 0x18, 0x37, "p11:AE48, p11:AE88"),
    (4, 0xAD53, [2, 3], 0x13, 0x00, 0x14, 0x38, 0x18, 0x20, 0x1A, "p11:AD45, p11:AD88"),
    (5, 0xAFFE, [4], 0x16, 0x17, 0x1E, 0x18, 0x10, 0x18, 0x17, "p11:AFD9, p11:B0E3"),
]
CARGAS = {5: (0xB3AF, 0xB3BC)}       # los demas, (0x556F, 0x559A)


def ficha_de_jefe(n):
    v = B.Ventana((7, 8, 9))
    a = v.w(0xBB01 + 2 * n)
    f, c = v(a), v(a + 1)
    return [[v(a + 2 + c * r + k) for k in range(c)] for r in range(f)]


def vram_de_jefe(fase, tipo):
    """La VRAM de la fase con lo que anade p00:4B20 (o p00:4C84)."""
    vram = V.de_la_fase(fase)
    v = B.Ventana((13, 14, 15))
    lista, copias = CARGAS.get(tipo, (0x556F, 0x559A))
    V.lista_caracteres(vram, v, lista)
    V.copias(vram, v, copias, True)
    return vram


def jefe(tipo, fase, escala=3):
    """El jefe montado como lo deja p01:67CE en la tabla de nombres."""
    from PIL import Image
    t = [j for j in JEFES if j[0] == tipo][0]
    _, ficha, _, cuerpo, barrera, nucleo, dy, dx, dx2 = t[:9]
    v = B.Ventana((1, 2, 11))
    assert (v(ficha + 7), v(ficha + 8), v(ficha + 9)) == (cuerpo, barrera, nucleo)
    piezas = [(ficha_de_jefe(cuerpo), 0, 0),
              (ficha_de_jefe(barrera), dy // 8, dx // 8),
              (ficha_de_jefe(nucleo), dy // 8, (dx + dx2) // 8)]
    filas = max(len(p) + r for p, r, _ in piezas)
    cols = max(len(p[0]) + c for p, _, c in piezas)
    tabla = [[0] * cols for _ in range(filas)]
    for p, r, c in piezas:
        for i, fila in enumerate(p):
            tabla[r + i][c:c + len(fila)] = fila
    sep = 4
    img = Image.new("RGB", (cols * 8 + 2 * sep, filas * 8 + 2 * sep), (40, 40, 40))
    # el cuerpo baja hasta y = 0x40 (p11:A90A): fila de pantalla 8
    pinta_forma(img, sep, sep, tabla, 8, vram_de_jefe(fase, tipo))
    return img.resize((img.width * escala, img.height * escala), Image.NEAREST)


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    os.makedirs(argv[1], exist_ok=True)
    usos = {}
    for fase in range(D.FASES):
        for clase, x, y, b, vuelta in lista_de_la_fase(fase):
            usos.setdefault(clase, {}).setdefault(fase, []).append((x, y, b, vuelta))
    for clase, ancho, filas, todas, cita in FAMILIAS:
        for fase, pos in sorted(usos.get(clase, {}).items()):
            fila = pos[0][1] // 8
            nombre = "objeto_c%02d_f%02d.png" % (clase, fase)
            formas = todas.get(fase, todas["*"]) if isinstance(todas, dict) else todas
            hoja(clase, fase, ancho, filas, list(formas), fila).save(os.path.join(argv[1], nombre))
            print("clase %2d fase %2d: %d x %d, %d formas, %d en la lista, filas %s  (%s)" % (
                clase, fase, ancho, filas, len(list(formas)), len(pos),
                sorted({p[1] // 8 for p in pos}), cita))
    for t in JEFES:
        for fase in t[2]:
            jefe(t[0], fase).save(os.path.join(argv[1], "jefe_t%d_f%02d.png" % (t[0], fase)))
        print("jefe %d fases %s: cuerpo %d, barrera %d, nucleo %d, %d golpes  (%s)" % (
            t[0], t[2], t[3], t[4], t[5], t[9] + 1, t[10]))
    for clase in sorted(usos):
        if clase not in [f[0] for f in FAMILIAS]:
            print("clase %2d fases %s: se pinta sola" % (clase, sorted(usos[clase])))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
