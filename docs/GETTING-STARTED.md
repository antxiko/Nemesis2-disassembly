# Getting started

This repository does not include the game. It includes the tools that, from
your own image of the cartridge, rebuild the commented listing, reassemble
it and check that the ROM comes out **byte for byte**.

## What you need

- The *Nemesis 2* image (RC-751), 131,072 bytes, in the root as
  `nemesis2.rom`. Its sha256:
  `227113f94d9900cb48d2f9e88627224dd8cc3d9504614a01e94cf6b23ba508dc`.
- `make`, `python3` and the `pasmo` assembler.
- For the pictures, Python with PIL.

## What to run

    make comprueba     # the ROM's sha256
    make               # trace, generate the listing, reassemble and run the tests
    make densidad      # how many instructions are commented, bank by bank
    make sanity        # the budget: not one byte unassigned

`make verify` reassembles the sixteen banks and compares them with the ROM: it
has to say `OK: la ROM entera reproducible byte a byte`.

## Where everything is

- `src/nemesis2_pNN.asm`: the listing of each bank (p00 to p15).
- `src/pNN.notes`: the names, comments and data blocks of each bank. The
  listing is generated from here.
- `tools/anota.py` and `tools/anotaciones.py`: the names of the routines and
  of the RAM, and the automatic comments.
- `tools/cartucho.py`: what the tracer needs to know about the mapper.
- `tools/dibuja.py`, `tools/vram.py`, `tools/titulo.py`, `tools/objetos.py`,
  `tools/enemigos.py`, `tools/nave.py`, `tools/final.py`: the pictures, drawn
  from the ROM.

## The pictures

    python tools/dibuja.py mapas work/dibujos
    python tools/titulo.py png work/dibujos/titulo.png --escala 2
    python tools/objetos.py work/dibujos/objetos
    python tools/enemigos.py png work/dibujos/enemigos
    python tools/nave.py png work/dibujos/armas/nave.png
    python tools/final.py png work/dibujos/final --escala 3
