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
    for clase in sorted(usos):
        if clase not in [f[0] for f in FAMILIAS]:
            print("clase %2d fases %s: se pinta sola" % (clase, sorted(usos[clase])))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
