# Nemesis 2 - a commented disassembly

*(También [en castellano](README.es.md).)*

The commented disassembly of **Nemesis 2** (Konami, 1987, RC-751) for the
MSX: a 128 KB MegaROM with Konami's SCC mapper, sixteen 8 KB banks.

- **100%** of the binary explained: 41,242 bytes of code and 89,830 of named
  data, not one byte unassigned.
- **43.4%** of the listing commented, 2,630 routines and labels, none below
  10% comments.
- The listing reassembles into the original ROM **byte for byte**.
- The twelve stages, the enemies, the objects, the five bosses, the ship, the
  power meter labels, the title and the end of the interior are **drawn from
  the ROM**, not captured.

The website: <https://antxiko.github.io/Nemesis2-disassembly/>
(in Spanish: <https://antxiko.github.io/Nemesis2-disassembly/es/>).

## Reproducing it

The cartridge image is not distributed. Put yours in the root as
`nemesis2.rom` (sha256 `227113f9...`) and run `make`. The details are in
[GETTING STARTED](docs/GETTING-STARTED.md).

## Legal

The game belongs to Konami and its rights holders. The `LICENSE` covers only
the tools, comments, analysis and documentation here. See
[LEGAL-NOTICE.md](LEGAL-NOTICE.md).
