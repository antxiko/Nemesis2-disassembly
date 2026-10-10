#!/usr/bin/env python3
"""Dibuja desde la ROM los mapas de las fases de Nemesis 2.

El mapa de una fase sale de las mismas tablas que lee p00:4889 al meter cada
columna nueva en la RAM (0xED00, 22 filas):
  - 0x7900[fase] (banco 13): las columnas de la fase, 6 bytes cada una, un
    metabloque por fila de metabloques;
  - 0x5557[fase] y 0x494A[fase] (banco 0): la tabla de metabloques y su
    umbral; los de debajo del umbral son de 16 bytes (4 x 4 caracteres, por
    filas) y los de encima de 8 (dos filas; las otras dos, el caracter 0);
    la sexta fila de metabloques solo pone 2 filas de caracteres (22);
  - los numeros 0-3 son los cuatro comunes de 0x6000, salvo en las fases 0 y
    8, y a los demas se les resta 4.
Los caracteres son los que deja en la VRAM p00:44F7 (tools/vram.py), y el
tercio de cada fila es el de la pantalla: el mapa va de la fila 0 a la 21
(p01:77F1 lo vuelca a 0x3800).

Uso: dibuja.py mapa <fase> <salida.png> [--escala N]
     dibuja.py mapas <directorio>      las 12
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import bloques as B      # noqa: E402
import vram as V         # noqa: E402

# La paleta del TMS9918. El color 0 (transparente) deja ver el fondo, que en
# las fases es negro (p01:61A6 pone el registro 7 con B = 0xE0).
PALETA = [
    (0, 0, 0), (0, 0, 0), (33, 200, 66), (94, 220, 120),
    (84, 85, 237), (125, 118, 252), (212, 82, 77), (66, 235, 245),
    (252, 85, 84), (255, 121, 120), (212, 193, 84), (230, 206, 128),
    (33, 176, 59), (201, 91, 186), (204, 204, 204), (255, 255, 255),
]

FASES = 12
FILAS = 22


def columnas(fase):
    """[(direccion, 6 numeros de metabloque)] de la fase."""
    v = B.Ventana((13, 14, 15))
    col = [v.w(0x7900 + 2 * k) for k in range(FASES)]
    fins = sorted(col) + [0x91A8]
    a = col[fase]
    f = fins[fins.index(a) + 1]
    return [[v(x + i) for i in range(6)] for x in range(a, f, 6)]


def metabloque(fase, n):
    """Las 16 casillas (4 filas de 4) del metabloque n de la fase. Los de 8
    bytes los copia p00:48F1 a 0xEAA8, que p01:68B9 pone a cero al empezar la
    fase: sus filas 2 y 3 son el caracter 0."""
    v0 = B.ventana_de(0)
    v = B.Ventana((13, 14, 15))
    if fase not in (0, 8):
        if n < 4:
            return [v(0x6000 + 16 * n + i) for i in range(16)]
        n -= 4
    m = v0.w(0x5557 + 2 * fase)
    t = v0(0x494A + fase)
    if n < t:
        return [v(m + 16 * n + i) for i in range(16)]
    a = m + 16 * t + 8 * (n - t)
    return [v(a + i) for i in range(8)] + [0] * 8


def filas_del_mapa(fase):
    """22 filas de numeros de caracter, 4 columnas por columna de metabloques."""
    filas = [[] for _ in range(FILAS)]
    for col in columnas(fase):
        for c in range(4):
            fila = 0
            for r, n in enumerate(col):
                mb = metabloque(fase, n)
                for k in range(4 if r < 5 else 2):
                    filas[fila].append(mb[4 * k + c])
                    fila += 1
    return filas


def pinta(filas, vram, escala=1):
    from PIL import Image
    alto, ancho = len(filas), len(filas[0])
    img = Image.new("RGB", (ancho * 8, alto * 8))
    px = img.load()
    for f in range(alto):
        tercio = f // 8
        for c in range(ancho):
            ch = filas[f][c]
            if ch is None:
                continue
            base = (tercio * 0x800 + ch * 8)
            for y in range(8):
                dib = vram[V.DIBUJOS + base + y]
                col = vram[V.COLORES + base + y]
                tinta, fondo = PALETA[col >> 4], PALETA[col & 0x0F]
                for x in range(8):
                    px[c * 8 + x, f * 8 + y] = tinta if dib & (0x80 >> x) else fondo
    if escala != 1:
        img = img.resize((img.width * escala, img.height * escala), Image.NEAREST)
    return img


def main(argv):
    if len(argv) >= 4 and argv[1] == "mapa":
        fase = int(argv[2])
        esc = int(argv[argv.index("--escala") + 1]) if "--escala" in argv else 1
        pinta(filas_del_mapa(fase), V.de_la_fase(fase), esc).save(argv[3])
    elif len(argv) >= 3 and argv[1] == "mapas":
        os.makedirs(argv[2], exist_ok=True)
        for fase in range(FASES):
            filas = filas_del_mapa(fase)
            pinta(filas, V.de_la_fase(fase)).save(os.path.join(argv[2], "fase_%02d.png" % fase))
            print("fase %2d: %d columnas de caracteres" % (fase, len(filas[0])))
    else:
        sys.exit(__doc__)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
