#!/usr/bin/env python3
"""Lo que el trazador de cartucho entero (tools/bancos.py) necesita saber de
ESTE cartucho: donde esta el despachador, como cambia de banco y por donde
arranca. bancos.py es maquinaria y no lleva direcciones de ningun juego; las
lee de aqui.

Nemesis 2 (Konami, RC-751, 1987), mapper Konami con SCC. Todo medido sobre
los bytes (tools/reconocimiento.py repasa cada escritura al mapper).
"""

# El despachador de Konami: `pop hl / add a,a / add a,l / ld l,a / jr nc /
# inc h / ld a,(hl) / inc hl / ld h,(hl) / ld l,a / jp (hl)`, con la tabla de
# destinos pegada detras del `call`. En este cartucho esta en p00:4084.
DESPACHADOR = 0x4084
DESPACHADORES = (0x4084,)

# Registro del mapper -> casilla del reparto (0x6000, 0x8000, 0xA000). El de
# 0x5000 no esta: solo lo escribe INIT, con un 0 (el banco 0 se queda fijo).
RANURA_REG = {0x7000: 0, 0x9000: 1, 0xB000: 2}

# Las copias en RAM de los registros: 0xF0F1/0xF0F2/0xF0F3, que las rutinas
# de banco escriben justo despues del registro y que la interrupcion
# (p00:4050-405F) y el sonido (p00:4AFD-4B0C, p00:5CE0-5CEF) leen para
# devolver lo que habia. 0xF0F0 es la del banco 0 y nadie la lee.
SOMBRA = {0xF0F1: 0, 0xF0F2: 1, 0xF0F3: 2}
SOMBRA_RANURA = {0: 0, 1: 1, 2: 2}
PONE_ZONA = ()
DEVUELVE_ZONA = ()

# Subrutinas del banco 0 que CAMBIAN de banco y vuelven con `ret`; sin ellas
# el trazador sigue tras el `call` con el reparto de antes. Cada una escribe
# el registro Y su copia en RAM. None = esa ranura no la toca.
PONE_BANCOS = {
    0x4108: (1, 2, 3),          # p00:4108  push af / ld a,1 / jr p00:411A: 0x7000 / inc a / 0x9000 / inc a / 0xB000, con su copia en 0xF0F1-3
    0x410D: (4, 5, 6),          # p00:410D  ld a,4 / jr p00:411A
    0x4112: (7, 8, 9),          # p00:4112  ld a,7 / jr p00:411A
    0x4117: (13, 14, 15),       # p00:4117  ld a,13 y cae en p00:411A
    0x4133: (None, None, 10),   # p00:4133  ld a,10 / jr p00:414E: solo 0xB000 y 0xF0F3
    0x4137: (None, None, 11),   # p00:4137  ld a,11 / jr p00:414E
    0x413B: (None, None, 12),   # p00:413B  ld a,12 / jr p00:414E
    0x413F: (None, None, 15),   # p00:413F  ld a,15 / jp p00:414E
    0x4144: (None, None, 9),    # p00:4144  ld a,9 / jp p00:414E
    0x4149: (None, None, 6),    # p00:4149  ld a,6 / jp p00:414E
    0x4157: (None, 2, 3),       # p00:4157  ld a,2 / jr p00:415D: 0x9000 / inc a / 0xB000
    0x415B: (None, 14, 15),     # p00:415B  ld a,14 y cae en p00:415D
    0x4E76: (None, 2, 3),       # p00:4E76  call p00:4137 / call 0xB8F4 / jp p00:4157
}


def semillas_iniciales(rom):
    """Los dos unicos puntos de entrada que el hardware garantiza.

    - INIT de la cabecera "AB" (0x4090): lo llama la BIOS al arrancar, con el
      mapper en su estado de encendido (bancos 1, 2 y 3 en 0x6000, 0x8000 y
      0xA000).
    - 0x4023: lo que INIT instala en el gancho H.KEYI, con `ld a,0xC3 /
      ld (0xFD9A),a / ld hl,0x4023 / ld (0xFD9B),hl` (p00:4093-409B). Despues
      INIT se queda en `jr $` (p00:40E7): el juego entero corre desde la
      interrupcion.
    """
    init = rom[2] | (rom[3] << 8)
    return [(init, (1, 2, 3), "cabecera AB: INIT"),
            (0x4023, (1, 2, 3),
             "gancho de interrupcion H.KEYI: INIT escribe 0xC3 en 0xFD9A y esta"
             " direccion en 0xFD9B (p00:4093-p00:409B)")]
