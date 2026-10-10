#!/usr/bin/env python3
"""La nave de Nemesis 2, desde sus fichas, con codigo nuestro.

La nave son dos sprites de 16 x 16 (0xE407-0xE40A: [dibujo][color][dibujo]
[color]) que p11:A000 pone en los atributos 0xE280 en la misma posicion; con
0xE400 = 2 el segundo va 8 puntos a la derecha (salvo con Penguin Adventure en
la otra ranura, bit 2 de 0xF0F5). p03:A7C1 copia la ficha de 0xA879-0xA8C4:

  0xE400 = 1  0xA889 + 4 x (0xE1C9 & 3, el 3 vale 0): recta, con el bit 0
              (sube: 0xA94E[1] resta 0x80 a la y) y con el bit 1 (baja)
  0xE400 = 2  0xA895, igual, y 12 mas con el bit 2 de 0xE1C3 (el contador de
              cuadros, p00:5601): mientras 0xE401 no llega a 0 (p02:8E33); con
              0xE401 = 1 el segundo color pasa a 6 o 9 (bit 1 de 0xE1C3)
  0xE400 = 3  0xA8AD + 4 x 0xE441 (de 0 a 5, un paso cada 3 cuadros, p03:A846);
              lo pone p02:90A1 al coger la capsula de 0xEA60 = 4, la del
              rotulo 22 (R.DRILL), y p00:42FE carga sus dibujos (0x9D17 a
              0x1800 y 0x9D68 a 0x1960)
  vecino      con Penguin Adventure (p03:A79A salta a p03:A7F8): 0xA879 o
              0xA881 segun el bit 7 de 0xE1C2 (el jugador: p00:582E lo cambia
              al pasar al otro), y 4 mas con el bit 3 de 0xE1C3; los dibujos
              los carga p00:4381 (0xBF19 a 0x1800 y 0xBF82 a 0x19E0, banco 12)

Uso: nave.py png <salida.png> [--escala N]
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import bloques as B      # noqa: E402
import vram as V         # noqa: E402
import dibuja as D       # noqa: E402

FICHAS = 0xA879          # banco 3


def ficha(a):
    v = B.ventana_de(3)
    return [v(a + i) for i in range(4)]


def vram_normal():
    return V.sprites_de_la_fase(0)


def vram_drill():
    return V.sprites_de_la_fase(0, drill=True)


def vram_vecino():
    return V.sprites_de_la_fase(0, vecino=True)


def sprite(px, vram, n, color, x0, y0):
    """Un sprite de 16 x 16 (dibujo n, columna izquierda y luego derecha); el
    color 0 no pinta."""
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


def nave(px, vram, f, x0, y0, desvio=0):
    """El segundo sprite primero: el de numero mas bajo (el primero) queda
    encima."""
    sprite(px, vram, f[2], f[3], x0 + desvio, y0)
    sprite(px, vram, f[0], f[1], x0, y0)


GRUPOS = [
    # (titulo, vram, direcciones de ficha, desvio del segundo sprite)
    ("0xE400 = 1", vram_normal, [0xA889, 0xA88D, 0xA891], 0),
    ("0xE400 = 2", vram_normal, [0xA895, 0xA899, 0xA89D, 0xA8A1, 0xA8A5, 0xA8A9], 8),
    ("0xE400 = 3", vram_drill, [0xA8AD + 4 * k for k in range(6)], 0),
    ("Penguin Adventure", vram_vecino, [0xA879, 0xA87D, 0xA881, 0xA885], 0),
]


def hoja(escala=3):
    from PIL import Image
    ancho, alto = 32, 24
    img = Image.new("RGB", (6 * ancho, len(GRUPOS) * alto), (40, 40, 40))
    px = img.load()
    for g, (_, hace_vram, fichas, desvio) in enumerate(GRUPOS):
        vram = hace_vram()
        for k, a in enumerate(fichas):
            for x in range(ancho - 2):
                for y in range(alto - 2):
                    px[k * ancho + 1 + x, g * alto + 1 + y] = (0, 0, 0)
            nave(px, vram, ficha(a), k * ancho + 4, g * alto + 4, desvio)
    return img.resize((img.width * escala, img.height * escala), Image.NEAREST)


def main(argv):
    if len(argv) >= 3 and argv[1] == "png":
        esc = int(argv[argv.index("--escala") + 1]) if "--escala" in argv else 3
        hoja(esc).save(argv[2])
    else:
        sys.exit(__doc__)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
