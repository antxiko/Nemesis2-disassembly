#!/usr/bin/env python3
"""La VRAM de Nemesis 2, cargada como la carga el cartucho, con codigo nuestro.

El VDP esta en SCREEN 2 (p00:5D1D): dibujos de caracteres en 0x2000 (tres
tercios de 0x800), colores en 0x0000, nombres en 0x3800, dibujos de sprite en
0x1800 y atributos en 0x3B00. Aqui se hace en Python lo mismo que hacen estas
rutinas del cartucho, cada una con su formato:

  p00:4A8C  rachas a la VRAM (0 acaba; < 0x80 repite el byte siguiente;
            0x80 trae otro destino; > 0x80 copia n & 0x7F bytes)
  p00:4595  lista de caracteres: fichas [tercios][dibujos][caracter][colores]
            (bit 0 de tercios: el tercero, +0x1000; bit 1: el segundo, +0x800;
            bit 2: el primero)
  p00:454E  copias de caracteres VRAM -> VRAM: [origen][destino][marcas]
            [cuantos]; el tercio de origen sale de los bits 2-1 de las marcas
            (p00:4675) y los de destino de los bits 5-3 (p00:462D); con 0xF000
            = 0 se copian en espejo (p00:4617 invierte los bits de cada fila de
            dibujo) y con 0xF000 = 1 cabeza abajo (p00:45EA invierte las filas
            de dibujo y de color)
  p00:44F7  los caracteres de una fase: la lista comun 0x6048, la de la fase
            (0x6000[fase]) y sus copias en espejo (0x6018[fase]) y cabeza abajo
            (0x6030[fase]), con los bancos 7-8-9 (en la fase 8, las mismas
            listas, pintadas poco a poco por p00:46C4)

Uso como modulo: v = vram.de_la_fase(fase) -> bytearray de 16 KB.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import bloques as B   # noqa: E402

DIBUJOS = 0x2000
COLORES = 0x0000
NOMBRES = 0x3800


def rachas(vram, v, origen, destino):
    """p00:4A8C."""
    a, d = origen, destino
    while True:
        n = v(a)
        a += 1
        if n == 0:
            return a
        if n == 0x80:
            d = v.w(a)
            a += 2
        elif n < 0x80:
            x = v(a)
            a += 1
            for _ in range(n):
                vram[d & 0x3FFF] = x
                d += 1
        else:
            for _ in range(n & 0x7F):
                vram[d & 0x3FFF] = v(a)
                a += 1
                d += 1


def lista_caracteres(vram, v, ix):
    """p00:4595."""
    while v(ix) != 0:
        tercios = v(ix)
        for bit, base in ((0, 0x1000), (1, 0x0800), (2, 0x0000)):
            if tercios >> bit & 1:
                hl = v(ix + 3) * 8 + base
                rachas(vram, v, v.w(ix + 1), DIBUJOS + hl)
                rachas(vram, v, v.w(ix + 4), COLORES + hl)
        ix += 6


def copias(vram, v, ix, cabeza_abajo):
    """p00:454E, con 0xF000 = 0 (espejo) o 1 (cabeza abajo)."""
    while v(ix) != 0:
        marcas = v(ix + 2)
        n = (marcas >> 6) & 3
        largo = 3
        if not n:
            n = v(ix + 3)
            largo = 4
        nbytes = n * 8
        # p00:4675: de que tercio se lee
        if marcas & 4:
            t = 0x0000
        elif marcas & 2:
            t = 0x0800
        else:
            t = 0x1000
        o = v(ix) * 8 + t
        dib = bytearray(vram[(DIBUJOS + o + i) & 0x3FFF] for i in range(nbytes))
        col = bytearray(vram[(COLORES + o + i) & 0x3FFF] for i in range(nbytes))
        if not cabeza_abajo:
            # p00:4617: los bits de cada byte de dibujo al reves
            dib = bytearray(int("{:08b}".format(x)[::-1], 2) for x in dib)
        else:
            # p00:45EA: las 8 filas de cada caracter al reves, dibujo y color
            for k in range(n):
                dib[8 * k:8 * k + 8] = dib[8 * k:8 * k + 8][::-1]
                col[8 * k:8 * k + 8] = col[8 * k:8 * k + 8][::-1]
        # p00:462D: a que tercios se escribe
        for bit, base in ((3, 0x1000), (4, 0x0800), (5, 0x0000)):
            if marcas >> bit & 1:
                d = v(ix + 1) * 8 + base
                for i in range(nbytes):
                    vram[(DIBUJOS + d + i) & 0x3FFF] = dib[i]
                    vram[(COLORES + d + i) & 0x3FFF] = col[i]
        ix += largo


def de_la_fase(fase):
    """La VRAM de caracteres de la fase, como la deja p00:44F7 (y p00:4337)."""
    vram = bytearray(0x4000)
    v = B.Ventana((7, 8, 9))
    lista_caracteres(vram, v, 0x6048)
    # En la fase 8, p00:44F7 no las carga: deja en 0xE1E0, 0xE1E2 y 0xE1E4 las
    # mismas tres listas (0x61DD, 0x6281 y 0x64A7, las entradas 8 de las tablas)
    # y p00:46C4 las pinta en tres pasos, con unas mascaras que van girando
    # hasta 0xFF: la VRAM acaba igual que en las demas fases.
    lista_caracteres(vram, v, v.w(0x6000 + 2 * fase))
    copias(vram, v, v.w(0x6018 + 2 * fase), False)
    copias(vram, v, v.w(0x6030 + 2 * fase), True)
    lista_caracteres(vram, v, 0x4358)        # p00:4337 (sin vecino), con 7-8-9 puestos
    return vram


# ------------------------------------------------------------------ sprites
#
# Los dibujos de sprite (16 x 16: 32 bytes, la columna izquierda y luego la
# derecha) van en 0x1800. L_43A5 pone los de la fase:
#   p00:4368  rachas de 0x936F a 0x1800 y de 0x942B a 0x1960 (sin vecino)
#   p00:4497  rachas de 0x93C0 a 0x18C0
#   p00:44BE  rachas de 0x94B8 a 0x1A20
#   p00:43C4  las copias de 0x44EA y la lista de la fase 0x92B3[fase]
#             ([n][rachas] a 0x1800 + 8 x n, p00:44D1) y las copias de
#             0x9348[fase]
# Las copias (p00:43DA): fichas [tipo][cuantos][origen][destino] (numeros de
# dibujo de 8 bytes); el tipo 1 cabeza abajo (p00:43EE invierte el orden de
# las 16 filas de cada columna) y los demas en espejo (p00:4ABD invierte los
# bits y cambia una columna por la otra).
SPRITES = 0x1800


def copias_de_sprites(vram, v, ix):
    """p00:43DA."""
    while v(ix) != 0:
        tipo, n, o, d = v(ix), v(ix + 1), v(ix + 2), v(ix + 3)
        if n:
            for k in range(n):
                src = vram[SPRITES + o * 8 + 32 * k:SPRITES + o * 8 + 32 * k + 32]
                if tipo == 1:
                    dst = src[0:16][::-1] + src[16:32][::-1]
                else:
                    r = bytes(int("{:08b}".format(x)[::-1], 2) for x in src)
                    dst = r[16:32] + r[0:16]
                a = SPRITES + d * 8 + 32 * k
                vram[a:a + 32] = dst
        ix += 4


def sprites_de_la_fase(fase, vram=None, vecino=False, drill=False):
    """La VRAM con los dibujos de sprite que deja L_43A5 en la fase. vecino:
    Penguin Adventure en la otra ranura (bit 2 de 0xF0F5: p00:4381 con el
    banco 12 en vez de p00:436F); drill: 0xE400 = 3 (p00:42FE)."""
    if vram is None:
        vram = de_la_fase(fase)
    v = B.Ventana((7, 8, 9))
    if vecino:
        v12 = B.Ventana((7, 8, 12))
        rachas(vram, v12, 0xBF19, 0x1800)
        rachas(vram, v12, 0xBF82, 0x19E0)
    else:
        rachas(vram, v, 0x936F, 0x1800)
        rachas(vram, v, 0x942B, 0x1960)
    rachas(vram, v, 0x93C0, 0x18C0)
    if drill:
        rachas(vram, v, 0x9D17, 0x1800)
        rachas(vram, v, 0x9D68, 0x1960)
    rachas(vram, v, 0x94B8, 0x1A20)
    copias_de_sprites(vram, B.ventana_de(0), 0x44EA)
    a = v.w(0x92B3 + 2 * fase)
    while v(a):
        rachas(vram, v, v.w(a + 1), SPRITES + 8 * v(a))
        a += 3
    copias_de_sprites(vram, v, v.w(0x9348 + 2 * fase))
    return vram
