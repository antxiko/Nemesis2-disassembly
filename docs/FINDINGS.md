# Findings

What turned up when the cartridge was taken apart. Everything is read in the
code; what has not been checked by playing is said.

## Three words in the pause, with Q*bert alongside

F1 stops the game and lets you type (`p03:BD7C`), but only if the *Q\*bert*
cartridge is in the other slot (`0xF0F5` bit 0). RETURN compares what was
typed with three words (`p03:BEB0`):

- **LARS18TH** fills the power meter and the weapons, with a shield and two
  options (`p03:BDD8`).
- **NEMESIS** skips to the next stage (`p03:BE87`).
- **METALION** makes the ship untouchable for 30 times 32 frames
  (`p03:BE90`).

## The other cartridge matters

At start-up the game checks the four slots and their subslots (`p03:BCB1`):

- With *Maze of Galious* in the other slot, the equipment is kept when the ship is lost
  (`p02:8E7C`), and the power meter's BACK UP box gives it back in the next
  life (`p01:7DD9`).
- With *Penguin Adventure*, the ship is a penguin, blue for player 1 and
  magenta for player 2 (`p03:A82E`).
- With a cartridge carrying 6 particular bytes at 0x7FFA, the high score is
  not recorded (`p00:5B68`) and the score code does not appear at the end
  (`p00:5C12`).

## Three secret stages

Stages 3, 6 and 10 hide an entrance at a fixed column (`p03:BF3A`). Touching
it stops the scroll for 64 frames, destroys every enemy and then runs at
double speed into stage 9, 10 or 11. They are made of blocks that break (the
0xA0 character, `p02:8481`) and their list carries capsules (`p01:7248`).
At the end the game goes back to the stage that was due (`p01:7AC2`).

## You have to go into the boss

Beating it is not enough: if the ship does not go through its mouth within
300 frames, there is no interior and no captured weapon (`p11:A95B`).

## The text marks the ending

Beating the stage 7 boss brings DR.VENOM IS FAST APPROACHING NEMESIS, RETURN
IMMEDIATELY! (`p14:94D1`) and the way back begins. The real ending comes after
the stage 0 core (`p10:BBAC`): OPERATIONS TO ERADICATE VENOM WERE ACHIEVED BY
METALION.

## A `jr z` that looks at something else

At `p03:B72E` the `jr z` follows an `ld`, which does not touch the flags: what
it looks at is the earlier `cp 028h`. That is why class 1 has 10 hits only if
its Y is exactly 0x28, and 7 in every other case.

## Japan or not

BIOS byte 0x002B decides between GRADIUS and NEMESIS in the title
(`p01:6173`), and between the Japanese and English texts in the story and the
ending (`p10:A0A7`).
