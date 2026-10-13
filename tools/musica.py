#!/usr/bin/env python3
"""La musica del cartucho (PSG y SCC), ejecutando su motor de sonido
(ver motor_musica.py).

Con el estado de arranque de `empieza_todo` (p00:5CBD: 0xE1AE-0xE1AF = 0xFF,
0xE1B0-0xE1B9 = 1 y el mezclador 0xBF en 0xE1A6) se vuelca el SCC con
p04:71AE; despues `sonido` (p00:4AE4, A = numero) pide la pieza y, cada
cuadro, el sonido del cuadro (p04:6934, bancos 4, 5 y 6) la toca, como la
interrupcion (p00:4048). El mapper es el Konami SCC: el banco 0x3F en 0x8000
abre el SCC en 0x9800-0x98FF. MegaROM de 128 KB.
Uso:  musica.py registros 0x3E [cuadros] | mp3 0x3E f.mp3 | todas docs/audio
      musica.py barrido 0x01 0x7F | emu | python tools/unicas.py 0x01 0x7F
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
from motor_musica import P  # noqa: E402

TABLA = "ninguna llamada directa: sale de la tabla de pistas por un número calculado"

PIEZAS = [
    P(0x3E, "La pieza del 0x5781", "The tune at 0x5781", "`L_5781`"),
    P(0x3F, "Empieza la historia", "The story begins", "`empieza_historia`"),
    P(0x40, "Empieza el final", "The ending begins", "`final_empieza`"),
    P(0x41, "El final de verdad", "The real ending", "`final_de_verdad`"),
    P(0x3B, "Estalla el jefe", "The boss blows up", "`jefe_estalla` y `L_915D`"),
    P(0x28, "El aviso parpadea", "The warning blinks", "`aviso_parpadea`"),
    P(0x3A, "La pieza del 0x925C", "The tune at 0x925C", "`L_925C`"),
    P(0x3D, "La pieza del 0x8ECE", "The tune at 0x8ECE", "`L_8ECE`"),
    P(0x42, "La pieza del 0x583A", "The tune at 0x583A", "`L_583A`"),
] + [P(n, "Pista 0x%02X de la tabla" % n, "Table track 0x%02X" % n, TABLA)
     for n in list(range(0x29, 0x2A)) + list(range(0x2B, 0x2F))
     + list(range(0x30, 0x37)) + [0x5B]]

PAGINA = motor_musica.pagina_basica(
    "el sonido del cuadro, p04:6934, y `sonido`, p00:4AE4, que apunta la "
    "pieza; la interrupción lo llama en p00:4048 con los bancos 4, 5 y 6",
    "the per-frame sound, p04:6934, and `sonido`, p00:4AE4, which points the "
    "piece; the interrupt calls it at p00:4048 with banks 4, 5 and 6",
    "C-BIOS MSX1 japonés",
    [("la pieza 0x3E entera, 355 cuadros, tal como el juego la pide, con "
      "PSG y SCC (144 registros del SCC)",
      "tune 0x3E, whole, 355 frames, as the game asks for it, with PSG and "
      "SCC (144 SCC registers)"),
     ("la pieza 0x29, sus primeros 217 cuadros, y la 0x2E, sus primeros 218, "
      "con PSG y SCC (112 registros del SCC cada una)",
      "tune 0x29, its first 217 frames, and 0x2E, its first 218, with PSG "
      "and SCC (112 SCC registers each)")],
    [("El SCC",
      "Este cartucho lleva el chip de sonido SCC de Konami, además del PSG: "
      "cinco canales de onda de 32 muestras que suenan por 0x9800-0x98FF "
      "cuando el banco 0x3F está en 0x8000. Aquí se ejecuta el motor, se "
      "recogen sus escrituras a las formas de onda (0x9800-0x987F), los "
      "periodos (0x9880-0x9889), los volúmenes (0x988A-0x988E) y las "
      "máscaras de canales (0x988F), y se mezclan con el PSG. El SCC se ha "
      "cotejado con openMSX igual que el PSG, registro a registro; el "
      "timbre es el de un SCC de manual, no una grabación del emulador. "
      "El quinto canal comparte la forma de onda del cuarto.",
      "The SCC",
      "This cartridge carries Konami's SCC sound chip as well as the PSG: "
      "five wavetable channels of 32 samples played through 0x9800-0x98FF "
      "when bank 0x3F sits at 0x8000. Here the engine runs, its writes to "
      "the waveforms (0x9800-0x987F), periods (0x9880-0x9889), volumes "
      "(0x988A-0x988E) and channel mask (0x988F) are collected and mixed "
      "with the PSG. The SCC was checked against openMSX like the PSG, "
      "register by register; the timbre is a textbook SCC, not a recording "
      "of the emulator. The fifth channel shares the fourth's waveform."),
     ("Cómo se pide una pieza",
      "`sonido` (p00:4AE4) mete los bancos 4, 5 y 6 y llama a la rutina de "
      "p04:6480 con el número en A; por debajo del 0x28 son efectos y del "
      "0x28 en adelante hay música. Antes se vuelca el estado de "
      "arranque con p04:71AE. La RAM del sonido está en 0xE000-0xE1D5. Las "
      "que suenan igual que otra se publican una vez, y las que duran más "
      "de 75 segundos sin volver a empezar se cortan a los 75.",
      "How a piece is asked for",
      "`sonido` (p00:4AE4) maps banks 4, 5 and 6 and calls the routine at "
      "p04:6480 with the number in A; below 0x28 are effects and from 0x28 "
      "up there is music. The start-up state is flushed first with "
      "p04:71AE. The sound RAM is at 0xE000-0xE1D5. Those that sound like "
      "another are published once, and those that last over 75 seconds "
      "without starting again are cut at 75.")])

CFG = dict(rom="nemesis2.rom", org=0x4000, mapper="konami_scc",
           bancos0=((0x4000, 0), (0x6000, 4), (0x8000, 5), (0xA000, 6)),
           bancos_frame=((0x6000, 4), (0x8000, 5), (0xA000, 6)),
           ram0=[(0xE1AE, 0xFF), (0xE1AF, 0xFF), (0xE1A6, 0xBF)]
           + [(0xE1B0 + i, 1) for i in range(10)],
           init=[(0x71AE, {})], frame=0x6934, pide=0x4AE4, banco_frame=4,
           banco_pide=0, ram=(0xE000, 0xE1D6), hz=60, psg0={7: 0xBF},
           romtype="KonamiSCC", max_s=75, piezas=PIEZAS, pagina=PAGINA,
           cotejado=[(0x3E, 355, None)])

if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
