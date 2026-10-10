# The code

## The numbers

**100%** of the 131,072 bytes is explained: 41,242 of code and 89,830 of
data. The seven banks with code have 2,630 routines and labels, and 8,602 of
their 19,811 instructions are commented: **43.4%**, with no routine below
10%. There are 1,361 named routines and 327 RAM addresses, each with the
address that justifies it.

## How it is organised

The game has 11 states (`p00:5615`): the intro, the title, the demo, the start
of the game, a life, the game, the loss of a life, GAME OVER, the return
after the interior, the pause and the ending. The game frame (`p00:416D`)
goes through the banks in order: the scroll, what appears, the ship, its
weapons, the enemies, the collisions, the boss, the sprites and the screen.

## What appears

Each stage has its lists ordered by scroll column: the enemies
(`p14:9A67`), the turrets (`p14:9554`), the character objects
(`p12:BA12`), the special capsules (`p12:BB72`) and the blocks
(`p01:7248`). On top of that, each 32-column stretch picks one or two of the
11 filler generators (`p14:99C7`, `p01:6E07`), and each stage has a wave of
6 enemies in a group (`p01:6E1D`): shooting down the whole wave leaves a
capsule (`p02:8988`).

## The enemies

There are 65 types, each with a 7-byte record (`p00:4F4C`): how many sprites
it uses or whether it is made of characters, its hits, its box, its drawing
and its colour. Each type has a routine to come out (`p00:4DF3`) and another
for each frame (`p01:63CD`). When they fall, almost all leave type 0x26, the
explosion, which according to its data turns into the power meter capsule
or into the one that destroys everything (`p02:9660`).

## The names

The names of the routines and of the RAM are in `tools/anotaciones.py`, and
`tools/anota.py` carries them to every call and every access in the listing.
