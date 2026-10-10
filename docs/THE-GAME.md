# The game

A horizontal scrolling shooter: the Metalion ship against Dr. Venom, planet
by planet. Everything on this page is read in the code and the pictures are
drawn from the ROM.

![The title](imagenes/titulo.png)

The title is built by `p01:615B` and its texts by `p01:61C1`. On a Japanese
MSX (BIOS byte 0x002B) the logo reads GRADIUS, and the story and ending texts
come out in Japanese.

## The stages

The map has twelve stages (`0xE201`). The game starts at stage 1 with 3 lives
(`p00:5AD8`). The next one is decided by `p01:7C59`: it goes up from 1 to 7,
and then down from 6 to 0 with `0xE20A` odd, which in many places brings more
enemies and more shots. Stage 0 is the final fortress, 8 is the interior of
each boss and 9, 10 and 11 are secret. Each stage has a checkpoint
(`p01:694A`) from which play resumes after losing a life.

The maps are built from their metablocks (`p13:7900`, `p00:4889`):

![Stage 0](imagenes/fase_00.png)
![Stage 1](imagenes/fase_01.png)
![Stage 2](imagenes/fase_02.png)
![Stage 3](imagenes/fase_03.png)
![Stage 4](imagenes/fase_04.png)
![Stage 5](imagenes/fase_05.png)
![Stage 6](imagenes/fase_06.png)
![Stage 7](imagenes/fase_07.png)
![Stage 8, the interior](imagenes/fase_08.png)
![Stage 9](imagenes/fase_09.png)
![Stage 10](imagenes/fase_10.png)
![Stage 11](imagenes/fase_11.png)

What closes each stage is in its script (`p01:7A34`):

| Stage | When the scroll ends |
|---|---|
| 1 | boss 1 |
| 2 and 3 | boss 4 |
| 4 | 600 more frames, boss 5 and then boss 2 |
| 5 | a 600-frame corridor of hatches and then boss 2 |
| 6 | two pieces that throw rocks, no boss |
| 7 | boss 3 |
| 0 | a core of 100 hits |

## The enemies

There are 65 enemy types, each with its 7-byte record (`p00:4F4C`). Each
stage brings those of its list, its generators, its wave and those dropped by
the objects and bosses. Here they are with the drawing from their record and
the stage's sprite patterns; the number is the type.

![Stage 0 enemies](imagenes/enemigos_f00.png)
![Stage 1 enemies](imagenes/enemigos_f01.png)
![Stage 2 enemies](imagenes/enemigos_f02.png)
![Stage 3 enemies](imagenes/enemigos_f03.png)
![Stage 4 enemies](imagenes/enemigos_f04.png)
![Stage 5 enemies](imagenes/enemigos_f05.png)
![Stage 6 enemies](imagenes/enemigos_f06.png)
![Stage 7 enemies](imagenes/enemigos_f07.png)
![Interior enemies](imagenes/enemigos_f08.png)

The character objects are part of the map: hatches, turning heads, towers
that release enemies. Each class has its shapes (`p15:B661`):

![Class 9, stage 1](imagenes/objeto_c09_f01.png)
![Class 1, stage 2](imagenes/objeto_c01_f02.png)
![Class 7, stage 5](imagenes/objeto_c07_f05.png)
![Class 16, stage 4](imagenes/objeto_c16_f04.png)

## The bosses

There are five (`0xE340`), each with its 10-byte record (`p09:BB01`), its box
and its core. Boss 1 fires six bullets in a fan. Boss 2 charges and releases
four-sprite enemies. Boss 3 throws growing tongues. Boss 4 releases beams.
Boss 5 is ten pieces that come out two at a time.

![Boss 1](imagenes/jefe_1.png)
![Boss 2](imagenes/jefe_2.png)
![Boss 3](imagenes/jefe_3.png)
![Boss 4](imagenes/jefe_4.png)
![Boss 5](imagenes/jefe_5.png)

When one is beaten, its mouth stays open for 300 frames (`p11:A93F`). If the
ship goes in, it reaches the interior; if not, the boss blows up and there is
no interior.

## The interior

It has a core of 24 hits (`p02:8570`). When the ship passes its X the
13-step ending starts (`p01:74A2`), with YOU CAPTURED. The prize depends on
how many frames the boss fight lasted (`p02:9218`): under 300, two weapons;
under 900, one; otherwise, NOTHING.

![Two weapons](imagenes/final_dos.png)
![One weapon](imagenes/final_una.png)
![None](imagenes/final_nada.png)

## The ship and the power meter

The red capsules move the lit box of the power meter, and the other button
uses it (`p01:7D4F`). The meter has more or fewer boxes depending on the
captured weapons (`p02:8060`). The seven that can be captured, in order, are
UP LASER, DOWN LASER, NAPALM MISSILE, REFLEX RING, EXTEND LASER, BACK BEAM
and FIRE BLASTER. The shield takes 10 hits, and the blue capsule destroys
every enemy on the screen.

![The ship](imagenes/nave.png)

The 25 power meter labels (`p14:9BD3`):

![The labels](imagenes/rotulos.png)

The special capsules appear on the map and last 15 seconds
(`p02:9034`). With D.VARRIOR the options circle the ship; R.DRILL turns the
ship into a drill that breaks walls; E.SLOW makes the enemies move every
other frame; VECTOR changes the shot.

![The capsules](imagenes/recogidas.png)

From left to right: the power meter one (0x29), the one that destroys
everything (0x2A), the extra life (0x2B), the two point ones (0x2C and 0x2D),
and D.VARRIOR, R.DRILL, E.SLOW and VECTOR.
