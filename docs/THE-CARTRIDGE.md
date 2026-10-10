# The cartridge

## The machine

A first-generation MSX: the TMS9918 VDP in SCREEN 2, the PSG and the SCC the
cartridge carries itself. The VDP registers come from the table at
`p00:5D1D`: names at 0x3800, colours at 0x0000, patterns at 0x2000, sprite
attributes at 0x3B00 and their patterns at 0x1800.

## The mapper

It is Konami's with SCC: sixteen 8 KB banks. Bank 0 is fixed at 0x4000 and
the other three slots are chosen by writing to 0x7000, 0x9000 and 0xB000
(`p00:4108`-`p00:415D`). The game keeps a copy of each in
`0xF0F1`-`0xF0F3`, and the interrupt puts them back from there
(`p00:4050`). Writing 0x3F to 0x9000 brings up the SCC registers at 0x9800
(`p04:71D3`).

## The interrupt

INIT (`p00:4090`) installs the H.KEYI hook and stays in `jr $`: the whole game
runs inside the interrupt (`p00:4023`). First comes the sound, with banks
4-5-6 (`p04:6934`). Then, if the previous frame has finished (`0xE1C5`), a
game frame starts: the previous frame's screen goes to the VRAM
(`p00:5D2A`) and then the game state runs (`p00:5601`).

## The sound

It lives in bank 4. There are 8 channels of 40 bytes from `0xE000`: 3 for the
PSG and 5 for the SCC. There are 67 sounds, each with its header of channels
and priority (`p04:6612`); a score only takes a channel if its priority is not
lower than the one playing (`p04:655D`). Scores have 31 commands
(`p04:6D27`) and the SCC uses its own waveforms (`p04:6000`). In the pause,
sound 0xF3 saves the channels and 0xF2 puts them back (`p04:65DE`,
`p04:65A1`).

## The RAM

The game uses `0xE000`-`0xEFFF`, which INIT clears. The 12 enemies are
64-byte records at `0xE600`, the 10 bullets are at `0xE900` and the ship's 9
shots at `0xE470`. The screen is built in RAM, at `0xED00`, and copied whole
to the VRAM every frame (`p01:77F1`). The sprites are ordered at `0xE280`
and each frame starts from a different one (`p01:77B6`), so they flicker
instead of vanishing.
