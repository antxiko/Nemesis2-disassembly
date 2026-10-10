#!/usr/bin/env python3
"""El final de la fase 8 (el interior en el que se entra tras un jefe), la
pantalla de YOU CAPTURED, montada desde la ROM con codigo nuestro.

Se entra en la fase 8 al tocar la boca del jefe muerto (p02:92A4 pone 0xE22B;
p01:7C2D guarda en 0xE22A la fase que sigue y salta a la 8). Su scroll para en
la columna 0x9F (la fila 8 de la tabla 0x6986 pone 0xE325), asi que la ultima
pantalla son las columnas 128-159 del mapa. A la columna 124 (0xE203 = 0x7F)
p02:8570 pone una pieza de 24 golpes (0xEA90: x 0xE0, y 0x40); en cuanto la nave
la pasa (0xE406 >= 0xEA92), p02:8653 arranca la maquina de 0xE3C0 (p01:74A2,
13 pasos, los destinos de 0x74AA). El bufer de nombres 0xED00 es la fila 0
(p01:77F1 lo vuelca a 0x3800):

  paso 1  p01:76E5 lleva la nave a y 0x48, x 0x50 y espera al fin del scroll
  paso 2  cada 10 cuadros una columna mas de 0x7738 en las filas 9 y 10,
          columnas 12-15 (caracteres 0xB1-0xB8)
  paso 3  60 cuadros parpadeando las fichas 0 y 1 de 0x7758 (4 x 4 en las
          filas 8-11, columnas 16-19)
  paso 4  las fichas 2, 3, 4 y 1 (0x7565), cada 4 cuadros
  paso 5  borra filas 15-19, columnas 4-27; p11:B77F carga en el tercer tercio
          las letras Y O U C A P T R E D N H (0xB7A4, en 0xBB-0xC6) e I G
          (0xB7B1, en 0x9B-0x9C), blancas; y 0x7725 escribe en la fila 16,
          columna 10: YOU CAPTURED
  paso 6  segun 0xE444 (p02:924A, al morir el jefe: menos de 300 cuadros de
          pelea 2, menos de 900 1, si no 0; con 0xE20F = 6 siempre 1 y con 7 o
          mas 0):
            0  0x7731 en la fila 18, columna 12: NOTHING
            1  un rotulo (p01:7690) en la fila 18, columna 12
            2  dos rotulos, en las columnas 7 y 17
          Cada rotulo: p00:53F9 dibuja el de 0x9BD3[0x77A8 + 0xE20F] (banco
          14) en 8 caracteres del tercer tercio (0x8B o 0x93: una raya
          arriba, 6 filas del dibujo y otra raya), con colores 0xA4, y
          p02:80BD sube 0xE20F. 0x77A8 tiene 6 bytes: con 0xE20F = 6 se lee
          el primero de 0x77AE (9).

Uso: final.py png <directorio> [--escala N]
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import bloques as B      # noqa: E402
import vram as V         # noqa: E402
import dibuja as D       # noqa: E402

FASE = 8
TERCERO = 0x1000


def letras(vram, texto, caracter):
    """p11:B75E: las letras (A = 1) de 0xB81C, al tercer tercio desde el
    caracter dado; p11:B77F les pone el color 0xF0."""
    v = B.ventana_de(11)
    for i, n in enumerate(texto):
        a = V.DIBUJOS + TERCERO + 8 * (caracter + i)
        for k in range(8):
            vram[a + k] = v(0xB81C + 8 * n + k)
            vram[V.COLORES + TERCERO + 8 * (caracter + i) + k] = 0xF0


def texto_de(v, a):
    t = []
    while v(a):
        t.append(v(a))
        a += 1
    return t


def rotulo(vram, n, caracter):
    """p00:53F9 con A = n en el caracter dado del tercer tercio, y el
    FILVRM de p01:76B5 (colores 0xA4)."""
    v = B.Ventana((1, 14, 15))
    p = v.w(0x9BD3 + 2 * n)
    raya = 0xFF if n - 1 < 0x14 else 0x00
    for k in range(8):
        a = V.DIBUJOS + TERCERO + 8 * (caracter + k)
        vram[a] = raya
        for f in range(6):
            vram[a + 1 + f] = v(p + 6 * k + f)
        vram[a + 7] = raya
        for f in range(8):
            vram[V.COLORES + TERCERO + 8 * (caracter + k) + f] = 0xA4


def arma(capturadas):
    """El numero de rotulo de la captura numero `capturadas` (0xE20F):
    0x77A8[0xE20F], que con 6 cae en 0x77AE."""
    return B.ventana_de(1)(0x77A8 + capturadas)


def pon(filas, fila, col, bytes_):
    for i, x in enumerate(bytes_):
        filas[fila][col + i] = x


def pantalla(premio, capturadas=0):
    """Las 22 filas y la VRAM al acabar el paso 6 con 0xE444 = premio."""
    v1 = B.ventana_de(1)
    v11 = B.ventana_de(11)
    vram = V.de_la_fase(FASE)
    mapa = D.filas_del_mapa(FASE)
    fin = 0x9F + 1                       # 0xE325: la ultima columna, la 159
    filas = [fila[fin - 32:fin] for fila in mapa]
    # paso 2: la ultima ficha de 0x7738 (las cuatro columnas)
    f = [v1(0x7738 + 24 + i) for i in range(8)]
    pon(filas, 9, 12, f[0:4])
    pon(filas, 10, 12, f[4:8])
    # paso 4: acaba en la ficha 1 (el ultimo byte de 0x7565)
    ficha = v1(0x7565 + 3)
    for k in range(4):
        pon(filas, 8 + k, 16, [v1(0x7758 + 16 * ficha + 4 * k + i) for i in range(4)])
    # paso 5
    for fila in range(15, 20):
        pon(filas, fila, 4, [0] * 24)
    letras(vram, texto_de(v11, 0xB7A4), 0xBB)
    letras(vram, texto_de(v11, 0xB7B1), 0x9B)
    pon(filas, 16, 10, [v1(0x7725 + i) for i in range(12)])
    # paso 6
    if premio == 0:
        pon(filas, 18, 12, [v1(0x7731 + i) for i in range(7)])
    elif premio == 1:
        rotulo(vram, arma(capturadas), 0x8B)
        pon(filas, 18, 12, range(0x8B, 0x93))
    else:
        rotulo(vram, arma(capturadas), 0x8B)
        pon(filas, 18, 7, range(0x8B, 0x93))
        rotulo(vram, arma(capturadas + 1), 0x93)
        pon(filas, 18, 17, range(0x93, 0x9B))
    return filas, vram


def rotulos(escala=1, numeros=None):
    """Los rotulos de las siete capturas (0xE20F de 0 a 6), uno por fila; o
    los de `numeros` (de 1 a 25: los 25 punteros de 0x9BD3)."""
    vram = V.de_la_fase(FASE)
    if numeros is None:
        numeros = [arma(k) for k in range(7)]
    filas = []
    for n in numeros:
        rotulo(vram, n, 0x8B)
        # en una fila del tercer tercio (la 16), que es donde estan
        im = D.pinta([[None] * 8] * 16 + [list(range(0x8B, 0x93))], vram)
        filas.append(im.crop((0, 128, 64, 136)))
    from PIL import Image
    img = Image.new("RGB", (64, len(filas) * 12))
    for k, im in enumerate(filas):
        img.paste(im, (0, 12 * k + 2))
    if escala != 1:
        img = img.resize((img.width * escala, img.height * escala), Image.NEAREST)
    return img


def main(argv):
    if len(argv) >= 3 and argv[1] == "png":
        esc = int(argv[argv.index("--escala") + 1]) if "--escala" in argv else 1
        os.makedirs(argv[2], exist_ok=True)
        for premio, nombre in ((0, "nada"), (1, "una"), (2, "dos")):
            filas, vram = pantalla(premio)
            D.pinta(filas, vram, esc).save(os.path.join(argv[2], "final_%s.png" % nombre))
        rotulos(esc).save(os.path.join(argv[2], "rotulos.png"))
        rotulos(esc, range(1, 26)).save(os.path.join(argv[2], "rotulos_todos.png"))
    else:
        sys.exit(__doc__)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
