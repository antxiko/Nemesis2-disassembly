#!/usr/bin/env python3
"""Los enemigos y los objetos que se recogen de Nemesis 2, desde sus fichas y
con la VRAM de cada fase, con codigo nuestro.

Cada tipo de enemigo (1-65, 0xE350) tiene su ficha de 7 bytes en p00:4F45 +
7 x tipo, que p00:4D1E copia al crearlo: el byte 0 a IX+0B (bit 7 se ve, bit
6 de caracteres, bits 0-5 cuantos sprites), los bytes 1-3 a IX+0D-IX+0F
(golpes y caja) y los bytes 4-6 a IX+30-IX+32 (dibujo y color del sprite, y
el dibujo de caracteres). p00:527A pone el primer sprite con IX+30/IX+31; los
dibujos de sprite son los de la fase (vram.sprites_de_la_fase). Muchos tipos
cambian de dibujo en su rutina; aqui sale el de la ficha.

Los de caracteres se pintan en la pantalla:
  tipo 1      la torreta (p01:65B1): 2 x 2 caracteres de la ficha p08:9DA5
              numero p01:66D0[lado x 12 + fase] + el angulo (0-5, p01:65EE)
  tipo 0x0B   2 x 2 (p03:A63C), la ficha p08:9DA5 numero 0x21 (byte 6)
  0x29-0x2D   2 x 2 caracteres seguidos desde p00:5265[tipo - 0x29]
              (p00:5212): 0x29 la capsula del medidor, 0x2A la que hace caer
              a todos, 0x2B la vida, 0x2C y 0x2D los de puntos
  capsulas especiales (0xEA60): 2 x 2 desde el caracter 0xE9 (p02:853E), con
              los dibujos y colores de la ficha p08:9094 + 4 x clase que
              carga p00:4319 (3 D.VARRIOR, 4 R.DRILL, 5 E.SLOW, 7 VECTOR)

Que tipos salen en cada fase: la lista de la fase (p14:9A67), sus
generadores (p14:99C7, p01:6E07), su oleada (p01:6EF2), las torretas
(p14:9554) y los que sueltan objetos, jefes y otros enemigos (SUELTAN).

Uso: enemigos.py png <carpeta> [--escala N]
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import bloques as B      # noqa: E402
import vram as V         # noqa: E402
import dibuja as D       # noqa: E402

FICHAS = 0x4F45          # p00, + 7 x tipo
GENERADORES = {1: 0x04, 2: 0x05, 3: 0x09, 4: 0x0D, 5: 0x0F, 6: 0x11,
               7: 0x14, 8: 0x16, 9: 0x19, 10: 0x0C, 11: 0x08}   # p01:6E07

# Los que no estan en las listas: los sueltan otros (fase: [(tipo, quien)])
SUELTAN = {
    0: [(0x38, "el nucleo, p02:926F")],
    1: [(0x23, "el jefe 1, p11:AB7B"), (0x34, "los giratorios, p11:B221"),
        (0x07, "la clase 9, p03:B407")],
    2: [(0x1D, "la clase 1, p03:B52D"), (0x39, "el jefe 4, p11:AD96")],
    3: [(0x10, "la clase 10, p03:B773"), (0x39, "el jefe 4, p11:AD96")],
    4: [(0x38, "el jefe 2, p11:AD0F"), (0x40, "la clase 14, p11:BEA1"),
        (0x41, "la clase 16, p11:BBA0"), (0x23, "el jefe 5, p11:B0F1")],
    5: [(0x25, "la clase 7, p03:A2B1"), (0x30, "las piezas, p02:8D39"),
        (0x38, "el jefe 2, p11:AD0F")],
    6: [(0x1F, "la clase 4, p03:B89F"), (0x32, "el suceso, p01:731E"),
        (0x33, "el suceso, p02:9121")],
    7: [(0x10, "la clase 10, p03:B773"), (0x22, "la clase 5, p03:B9E8"),
        (0x24, "el jefe 3, p11:AEAA")],
    8: [(0x33, "el nucleo, p02:85F8")],
}


# Los que cambian de dibujo al salir: el primero de su rutina (tipo: (dibujo,
# color) o, por fase, {fase: ...}); los demas, el de la ficha
SALIDA = {
    0x02: {3: (0x74, None)},                # p11:B8F4: en la fase 3
    0x09: {4: (0x74, None)},                # p02:9B85: p02:9B9F en la fase 4
    0x0C: (0xC4, None),                     # p02:9B2E: p02:9B48[0]
    0x0D: (0xB4, None, {4: (0x84, None)}),  # p02:9BC5: p02:9BEB / 9BF1
    0x0F: (0xF4, None),                     # p02:9C36: p02:9C3C[0]
    0x11: (0xEC, None, {5: (0xA4, None)}),  # p02:9CBF: p02:9D63 / 9D67
    0x1F: (0x80, None),                     # p03:B8FC
    0x38: (0xD0, 3),                        # p11:A619: el color p11:A634[3]
}


def dibujo_de_salida(t, fase):
    f = ficha(t)
    n, c = f[4], f[5]
    s = SALIDA.get(t)
    if isinstance(s, dict):
        s = s.get(fase)
    elif s is not None and len(s) == 3:
        s = s[2].get(fase, s[:2])
    if s:
        n = s[0]
        c = s[1] if s[1] is not None else c
    return n, c


def se_dibuja(t):
    """Los de sprite, y de los de caracteres los que son un bloque fijo; los
    demas (rayos, columnas y lenguas que crecen) no tienen un dibujo quieto."""
    return t in (1, 0x0B) or 0x29 <= t <= 0x2D or not ficha(t)[0] & 0x40


def ficha(t):
    v = B.ventana_de(0)
    return [v(FICHAS + 7 * t + i) for i in range(7)]


def tipos_de_la_fase(fase):
    """{tipo: de donde sale}."""
    s = {}
    if fase <= 8:
        v = B.Ventana((1, 14, 15))
        a = v.w(0x9A67 + 2 * fase)
        while not (v(a) == 0xFF and v(a + 1) == 0xFF):
            s.setdefault(v(a + 2) & 0x3F, "la lista")
            a += 4
        a = v.w(0x99C7 + 2 * fase)
        # un byte por cada 32 columnas, hasta el final del scroll (p01:6986)
        fin = B.ventana_de(1).w(0x6986 + 6 * fase + 4)
        for k in range((fin >> 5) + 1):
            for g in (v(a + k) >> 4, v(a + k) & 0x0F):
                if g in GENERADORES:
                    s.setdefault(GENERADORES[g], "el generador %d" % g)
        if fase < 8:
            s.setdefault(v(0x6EF2 + fase), "la oleada")
        if v(v.w(0x9554 + 2 * fase)) != 0xFF:
            s.setdefault(1, "las torretas")
    for t, quien in SUELTAN.get(fase, []):
        s.setdefault(t, quien)
    return s


def caracter(px, vram, n, tercio, x0, y0):
    """El caracter n del tercio con sus colores (el color 0, negro)."""
    base = 0x800 * tercio + 8 * n
    for y in range(8):
        b = vram[V.DIBUJOS + base + y] if hasattr(V, "DIBUJOS") else vram[0x2000 + base + y]
        c = vram[V.COLORES + base + y]
        for x in range(8):
            px[x0 + x, y0 + y] = D.PALETA[(c >> 4) if b & (0x80 >> x) else (c & 15)]


def bloque(px, vram, chars, filas, cols, x0, y0, tercio=1):
    for f in range(filas):
        for c in range(cols):
            caracter(px, vram, chars[f * cols + c], tercio, x0 + 8 * c, y0 + 8 * f)


def ficha_de_caracteres(n, filas, cols):
    """Los caracteres de la ficha n de p08:9DA5 (p00:52B8)."""
    v = B.Ventana((7, 8, 9))
    a = v.w(0x9DA5 + 2 * n)
    return [v(a + k) for k in range(filas * cols)]


def sprite(px, vram, n, color, x0, y0):
    if not color:
        return
    tinta = D.PALETA[color & 0x0F]
    base = V.SPRITES + 8 * n
    for col in range(2):
        for y in range(16):
            b = vram[base + 16 * col + y]
            for x in range(8):
                if b & (0x80 >> x):
                    px[x0 + 8 * col + x, y0 + y] = tinta


def hoja_de_la_fase(fase, escala=3):
    """Los tipos de la fase: los de sprite con el dibujo de su ficha, los de
    caracteres que se conocen, y su numero debajo."""
    from PIL import Image, ImageDraw
    vram = V.sprites_de_la_fase(fase)
    # el 0x38 solo sale con el jefe o el nucleo, que antes cargan con p00:4B51
    # sus dibujos (p09:BF6D en 0x1E80, el 0xD0 en adelante)
    vram38 = bytearray(vram)
    V.rachas(vram38, B.Ventana((7, 8, 9)), 0xBF6D, 0x1E80)
    tipos = [t for t in sorted(tipos_de_la_fase(fase)) if se_dibuja(t)]
    celda, alto = 28, 34
    por_fila = 12
    filas = (len(tipos) + por_fila - 1) // por_fila
    img = Image.new("RGB", (por_fila * celda, max(1, filas) * alto), (40, 40, 40))
    px = img.load()
    for k, t in enumerate(tipos):
        x0, y0 = (k % por_fila) * celda + 2, (k // por_fila) * alto + 2
        for y in range(24):
            for x in range(24):
                px[x0 + x, y0 + y] = (0, 0, 0)
        f = ficha(t)
        if t == 1:
            n = B.Ventana((1, 2, 3))(0x66D0 + fase)
            bloque(px, vram, ficha_de_caracteres(n, 2, 2), 2, 2, x0 + 4, y0 + 4)
        elif t == 0x0B:
            bloque(px, vram, ficha_de_caracteres(f[6], 2, 2), 2, 2, x0 + 4, y0 + 4)
        elif 0x29 <= t <= 0x2D:
            c = B.ventana_de(0)(0x5265 + t - 0x29)
            bloque(px, vram, [c, c + 1, c + 2, c + 3], 2, 2, x0 + 4, y0 + 4)
        elif not f[0] & 0x40:
            sprite(px, vram38 if t == 0x38 else vram, *dibujo_de_salida(t, fase),
                   x0 + 4, y0 + 4)
    img = img.resize((img.width * escala, img.height * escala), Image.NEAREST)
    d = ImageDraw.Draw(img)
    for k, t in enumerate(tipos):
        x0, y0 = (k % por_fila) * celda + 2, (k // por_fila) * alto + 2
        d.text((x0 * escala + 4, (y0 + 25) * escala), "%02X" % t, fill=(230, 230, 230))
    return img


def vram_con_capsula(fase, clase):
    """La VRAM de la fase con el caracter 0xE9 de la capsula especial clase
    (p00:4319: la ficha p08:9094 + 4 x clase, dibujos a 0x2748 y colores a
    0x0748 en los tres tercios)."""
    vram = V.sprites_de_la_fase(fase)
    v = B.Ventana((7, 8, 9))
    a = 0x9094 + 4 * clase
    for t in range(3):
        V.rachas(vram, v, v.w(a), 0x2748 + 0x800 * t)
        V.rachas(vram, v, v.w(a + 2), 0x0748 + 0x800 * t)
    return vram


def hoja_de_recogidas(fase=1, escala=3):
    """Las capsulas 0x29-0x2D y las especiales 3, 4, 5 y 7."""
    from PIL import Image
    img = Image.new("RGB", (9 * 22, 22), (40, 40, 40))
    px = img.load()
    vram = V.sprites_de_la_fase(fase)
    # 0x2B-0x2D solo salen de los bloques de las fases 7 y 9-11 (p01:7248)
    vram9 = V.sprites_de_la_fase(9)
    for k, t in enumerate(range(0x29, 0x2E)):
        c = B.ventana_de(0)(0x5265 + t - 0x29)
        bloque(px, vram if t < 0x2B else vram9, [c, c + 1, c + 2, c + 3], 2, 2,
               k * 22 + 3, 3)
    for k, clase in enumerate((3, 4, 5, 7)):
        vc = vram_con_capsula(fase, clase)
        bloque(px, vc, [0xE9, 0xEA, 0xEB, 0xEC], 2, 2, (5 + k) * 22 + 3, 3)
    return img.resize((img.width * escala, img.height * escala), Image.NEAREST)


def main(argv):
    if len(argv) < 3 or argv[1] != "png":
        print(__doc__)
        return 1
    escala = int(argv[argv.index("--escala") + 1]) if "--escala" in argv else 3
    os.makedirs(argv[2], exist_ok=True)
    for fase in range(12):
        hoja_de_la_fase(fase, escala).save(os.path.join(argv[2], "enemigos_f%02d.png" % fase))
    hoja_de_recogidas(1, escala).save(os.path.join(argv[2], "recogidas.png"))
    print("hecho:", argv[2])
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
