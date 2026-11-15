## Notes

Pokémon Reloaded The Last Beta 1.9.2.2 running natively on OpenGMK (Rust) with SDL2/KMSDRM.
No Wine or Windows emulation is used.

This is the centred build, selected for stability. In some battles the right edge of the battle
UI can be clipped, so the opponent's level may not be fully visible.

Controls: A/B/X/Y = Z/X/C/S; L1 = attack 4; R1 = Poké Ball; L3/R3 = Pokémon/items menus; L2/R2 = Mega/bag; Start = menu. Hold Select + A/B/X/Y/L1/R1 for party members/HMs 1-6; Select + D-pad = 7/8/9/0; Select + L3/R3/L2/R2 = use item/escape/flute/cancel switch; Select + Start = quit. Full map in the repository README.

The port does not include the game. Download the official Windows release from the F3R blog and
extract its contents into `ports/pokemonreloaded/` so that `data/` and the `.exe` sit next to
`gm8emulator`.

Thanks to **F3R Productions** for creating Pokémon Reloaded, to **Klisee** for the Android/OpenGMK
port that this work is based on, and to the OpenGMK contributors. Packaging for R36S/ArkOS by
**Kuranesx**.
