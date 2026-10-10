#!/usr/bin/env python3
"""La pantalla de titulo de Nemesis 2, montada desde la ROM con codigo nuestro.

Es la que pinta p01:621E, paso a paso:
  p01:615B  borra los nombres (p00:4A10) y carga los caracteres del logotipo:
            la lista 0x55A7 (p00:4595) y sus copias en espejo 0x55DE
            (p00:454E) con el banco 15; y SI EL MSX NO ES JAPONES (0x002B &
            0x0F distinto de 0) encima la lista 0xAA83 y las copias 0xAA96 del
            banco 12. Despues la fuente (p11:B6CD: cifras de 0xB7B4 a 0x2080
            y letras de 0xB81C a 0x2100 en los tres tercios, y sus colores a
            0xF0) y, con el banco 10, p10:A24C copia caracteres de uno a otro
            con los pares [origen][destino] de 0xB8F5 en tres zonas (0x2800,
            0x0000 y 0x0800).
  p10:B636  el logotipo: rachas por filas (p10:A67B) de 26 de ancho en la
            tabla de nombres desde 0x3843; de 0xB832 en un MSX japones y de
            0xB7A1 en los demas.
  p01:61C1  los textos (listas de p00:4A6B). Con 0xE1C0 < 2, el titulo:
            0xB904 (KONAMI 1987, PLAY SELECT y 1PLAYER) y, porque p01:61E7
            salta a p01:61E4 sin cargar DE, la lista que va detras, 0xB92B
            (2PLAYERS). Con 0xE1C0 >= 2, la presentacion: 0xB936 (KONAMI
            PRESENTS, THE), el nombre (0xB94F, GRADIUS, en un MSX japones;
            0x622D, NEMESIS, en los demas) y 0xB959 (SAGA CONTINUES...).

Uso: titulo.py png <salida.png> [japones] [presenta] [--escala N]
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import bloques as B      # noqa: E402
import vram as V         # noqa: E402
import dibuja as D       # noqa: E402


def filas_a_vram(vram, v, origen, destino, ancho):
    """p10:A67B: rachas a la tabla de nombres por filas de `ancho`; los ceros
    no se escriben (pero cuentan)."""
    a, fila, d, c = origen, destino, destino, ancho

    def pon(x):
        nonlocal d, c, fila
        if x:
            vram[d & 0x3FFF] = x
        d += 1
        c -= 1
        if c == 0:
            fila += 0x20
            d, c = fila, ancho

    while True:
        n = v(a)
        a += 1
        if n == 0:
            return a
        if n < 0x80:
            x = v(a)
            a += 1
            for _ in range(n):
                pon(x)
        elif n == 0x80:
            k, x = v(a), v(a + 1)
            a += 2
            for _ in range(k):
                pon(x)
                x = (x + 1) & 0xFF
        else:
            for _ in range(n & 0x7F):
                pon(v(a))
                a += 1


def lista_vram(vram, v, a):
    """p00:4A6B: [destino] y bytes; 0xFE otro destino; 0xFF acaba."""
    d = v.w(a)
    a += 2
    while True:
        x = v(a)
        a += 1
        if x == 0xFF:
            return a
        if x == 0xFE:
            d = v.w(a)
            a += 2
            continue
        vram[d & 0x3FFF] = x
        d += 1


def pares_de_caracteres(vram, v, a, base):
    """p10:A24C con E498 = 0 y un tercio: copia los 8 bytes del caracter
    origen al destino, dentro de la zona base."""
    while v(a):
        o, d = v(a) * 8 + base, v(a + 1) * 8 + base
        vram[d:d + 8] = vram[o:o + 8]
        a += 2


def pantalla(japones=False, presenta=False):
    vram = bytearray(0x4000)
    v15 = B.Ventana((1, 2, 15))
    V.lista_caracteres(vram, v15, 0x55A7)
    V.copias(vram, v15, 0x55DE, False)
    if not japones:
        v12 = B.Ventana((1, 2, 12))
        V.lista_caracteres(vram, v12, 0xAA83)
        V.copias(vram, v12, 0xAA96, False)
    v11 = B.ventana_de(11)
    for origen, destino, n in ((0xB7B4, 0x2080, 0x68), (0xB81C, 0x2100, 0xD8)):
        for t in range(3):
            for i in range(n):
                vram[destino + 0x800 * t + i] = v11(origen + i)
    for t in range(3):
        for i in range(0x158):
            vram[0x0080 + 0x800 * t + i] = 0xF0
    v10 = B.ventana_de(10)
    for base in (0x2800, 0x0000, 0x0800):
        pares_de_caracteres(vram, v10, 0xB8F5, base)
    filas_a_vram(vram, v10, 0xB832 if japones else 0xB7A1, 0x3843, 26)
    v1 = B.ventana_de(1)
    if not presenta:
        detras = lista_vram(vram, v10, 0xB904)
        lista_vram(vram, v10, detras)              # 0xB92B: el DE que queda
    else:
        lista_vram(vram, v10, 0xB936)
        if japones:
            lista_vram(vram, v10, 0xB94F)
        else:
            lista_vram(vram, v1, 0x622D)
        lista_vram(vram, v10, 0xB959)
    filas = [[vram[V.NOMBRES + 32 * f + c] for c in range(32)] for f in range(24)]
    return filas, vram


def main(argv):
    if len(argv) >= 3 and argv[1] == "png":
        esc = int(argv[argv.index("--escala") + 1]) if "--escala" in argv else 1
        filas, vram = pantalla("japones" in argv, "presenta" in argv)
        D.pinta(filas, vram, esc).save(argv[2])
    else:
        sys.exit(__doc__)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
