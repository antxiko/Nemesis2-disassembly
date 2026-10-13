# The music

Everything you hear here comes from running the cartridge's own sound engine (the per-frame sound, p04:6934, and `sonido`, p00:4AE4, which points the piece; the interrupt calls it at p00:4048 with banks 4, 5 and 6) on an emulated Z80, frame by frame at 60 per second, just as the game calls it. What the engine writes to the PSG is turned into sound with an AY-3-8910 (`tools/musica.py`). Each MP3 is the whole piece up to where it starts again, plus 8 seconds of the repeat fading out; those that do not repeat end where the engine ends.

## Checked against openMSX

The PSG writes have been compared frame by frame with those of openMSX (C-BIOS MSX1 japonés). In every frame the PSG ends up the same:

- tune 0x3E, whole, 355 frames, as the game asks for it, with PSG and SCC (144 SCC registers);
- tune 0x29, its first 217 frames, and 0x2E, its first 218, with PSG and SCC (112 SCC registers each).

The timbre is not checked: it is a textbook AY-3-8910, not a recording of the emulator. The probes are `tools/omsx_psg.tcl` and `tools/coteja_psg.py`.

## The SCC

This cartridge carries Konami's SCC sound chip as well as the PSG: five wavetable channels of 32 samples played through 0x9800-0x98FF when bank 0x3F sits at 0x8000. Here the engine runs, its writes to the waveforms (0x9800-0x987F), periods (0x9880-0x9889), volumes (0x988A-0x988E) and channel mask (0x988F) are collected and mixed with the PSG. The SCC was checked against openMSX like the PSG, register by register; the timbre is a textbook SCC, not a recording of the emulator. The fifth channel shares the fourth's waveform.

## How a piece is asked for

`sonido` (p00:4AE4) maps banks 4, 5 and 6 and calls the routine at p04:6480 with the number in A; below 0x28 are effects and from 0x28 up there is music. The start-up state is flushed first with p04:71AE. The sound RAM is at 0xE000-0xE1D5. Those that sound like another are published once, and those that last over 75 seconds without starting again are cut at 75.

## The tunes

**The tune at 0x5781** (0x3E)

Asked for by `L_5781`; lasts 5.9 s.

<audio controls preload="none" src="audio/musica_3E.mp3?v=e8bc159b"></audio>

**The story begins** (0x3F)

Asked for by `empieza_historia`; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_3F.mp3?v=e5f57450"></audio>

**The ending begins** (0x40)

Asked for by `final_empieza`; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_40.mp3?v=57557104"></audio>

**The real ending** (0x41)

Asked for by `final_de_verdad`; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_41.mp3?v=c95db9ed"></audio>

**The boss blows up** (0x3B)

Asked for by `jefe_estalla` y `L_915D`; lasts 3.2 s.

<audio controls preload="none" src="audio/musica_3B.mp3?v=7c127c1c"></audio>

**The warning blinks** (0x28)

Asked for by `aviso_parpadea`; lasts 11.3 s.

<audio controls preload="none" src="audio/musica_28.mp3?v=69f3d1f2"></audio>

**The tune at 0x925C** (0x3A)

Asked for by `L_925C`; lasts 14.7 s and starts again at second 3.5.

<audio controls preload="none" src="audio/musica_3A.mp3?v=b24e372e"></audio>

**The tune at 0x8ECE** (0x3D)

Asked for by `L_8ECE`; lasts 1.9 s.

<audio controls preload="none" src="audio/musica_3D.mp3?v=6e78baf5"></audio>

**The tune at 0x583A** (0x42)

Asked for by `L_583A`; lasts 5.8 s.

<audio controls preload="none" src="audio/musica_42.mp3?v=2cc4f018"></audio>

**Table track 0x29** (0x29)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 48.0 s and starts again at second 16.0.

<audio controls preload="none" src="audio/musica_29.mp3?v=1c37acc7"></audio>

**Table track 0x2B** (0x2B)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 66.2 s and starts again at second 32.0.

<audio controls preload="none" src="audio/musica_2B.mp3?v=85d05302"></audio>

**Table track 0x2C** (0x2C)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 64.0 s and starts again at second 12.8.

<audio controls preload="none" src="audio/musica_2C.mp3?v=a68ab776"></audio>

**Table track 0x2D** (0x2D)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 59.2 s and starts again at second 28.4.

<audio controls preload="none" src="audio/musica_2D.mp3?v=f91b18f4"></audio>

**Table track 0x2E** (0x2E)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 19.2 s and starts again at second 0.1.

<audio controls preload="none" src="audio/musica_2E.mp3?v=1a6ca048"></audio>

**Table track 0x30** (0x30)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_30.mp3?v=bafe8d8b"></audio>

**Table track 0x31** (0x31)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 57.0 s and starts again at second 27.8.

<audio controls preload="none" src="audio/musica_31.mp3?v=2a4db95e"></audio>

**Table track 0x32** (0x32)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 64.0 s and starts again at second 29.9.

<audio controls preload="none" src="audio/musica_32.mp3?v=3f027d73"></audio>

**Table track 0x33** (0x33)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 42.7 s and starts again at second 8.6.

<audio controls preload="none" src="audio/musica_33.mp3?v=a688c18d"></audio>

**Table track 0x34** (0x34)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 25.6 s and starts again at second 12.8.

<audio controls preload="none" src="audio/musica_34.mp3?v=f39a323a"></audio>

**Table track 0x35** (0x35)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 13.2 s and starts again at second 0.4.

<audio controls preload="none" src="audio/musica_35.mp3?v=808aaee8"></audio>

**Table track 0x36** (0x36)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 50.8 s and starts again at second 25.2.

<audio controls preload="none" src="audio/musica_36.mp3?v=20269543"></audio>

**Table track 0x5B** (0x5B)

Asked for by ninguna llamada directa: sale de la tabla de pistas por un número calculado; lasts 55.5 s and starts again at second 0.1.

<audio controls preload="none" src="audio/musica_5B.mp3?v=06b0273d"></audio>
