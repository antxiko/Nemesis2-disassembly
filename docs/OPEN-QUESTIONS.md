# Open questions

What is not settled, said as such.

## The check against the emulator

Every picture comes from the ROM, but none has yet been compared byte for
byte with the openMSX VRAM.

## The way back

The code goes from stage 7 to 6 and then down to 0 (`p01:7C59`). It has not
been checked by playing.

## The enemy drawings

Each type comes out with the drawing from its record, or with the first one
of its animation when its routine changes it on coming out. The animations
are not drawn. The beams, columns and growing tongues (0x23, 0x24,
0x39-0x3C, 0x41) have no fixed drawing and are not on the sheets.

## Data with no reader

The 2PLAYERS text at `p10:B92B` is only written because `p01:61E7` jumps
without loading DE. Drum hits 0xB0 and 0xC0 read outside their table
(`p04:6AAA`).

## The SCC after the pause

When the pause ends, the SCC channels are switched on with the value of
`0xE1C0`, which is the game state (`p04:65B7`).

## The shots of each weapon

Their types and what they do are known (`p03:ABC2`), but they are not drawn.
