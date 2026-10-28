# AGENTS.md — Pokémon Reloaded R36S

This repository packages the R36S/ArkOS port of **Pokémon Reloaded The Last Beta 1.9.2.2**.
The game itself is **not** included. Do not upload, commit or redistribute `data/` or the game
`.exe`; they belong to F3R Productions.

## Target

- Device: R36S (RK3326, Mali-G31, 640x480)
- OS: ArkOS (tested)
- Port path: `/roms2/ports/pokemonreloaded`
- Launcher: `/roms2/ports/Pokemon Reloaded.sh`
- SSH example: `ssh -i <key> ark@<device-ip>`

## What is in the release

- `Pokemon Reloaded.sh`: PortMaster/manual launcher.
- `pokemonreloaded/gm8emulator`: OpenGMK aarch64 binary, centred build.
- `pokemonreloaded/assets/`: OpenGMK UI assets, not game assets.
- `pokemonreloaded/gamecontrollerdb.txt`: R36S controller mapping.
- `pokemonreloaded/run.sh`, `backup_saves.sh`: runtime and save backup.
- `licenses/`: OpenGMK, ramen and udon licenses.
- `source/opengmk-r36s-source.tar.gz`: corresponding GPL source.

## Install with an agent

1. Download `pokemonreloaded.zip` from the latest GitHub release.
2. Extract it into the ports directory. On ArkOS with two cards this is `/roms2/ports/`.
3. Obtain the official game zip from
   <https://pokemon-reloaded.blogspot.com/2026/08/the-last-beta-192.html>.
   Use the user's local copy if they already have it; do not download from unofficial mirrors.
4. Run:

   ```bash
   ./tools/install-game.sh "/path/to/Proyecto Reloaded The Last Beta 1.9.2.2 Full.zip" \
     /roms2/ports/pokemonreloaded
   ```

   Or manually extract the game so the layout is:

   ```text
   /roms2/ports/pokemonreloaded/
   ├── gm8emulator
   ├── <original>.exe
   ├── data/
   └── ...
   ```

5. Ensure `gm8emulator` and the `.sh` files are executable:

   ```bash
   chmod +x /roms2/ports/pokemonreloaded/gm8emulator
   chmod +x /roms2/ports/pokemonreloaded/*.sh
   chmod +x "/roms2/ports/Pokemon Reloaded.sh"
   ```

6. KMSDRM needs the display. If GDM/Xorg is running on the device, stop it before launching:

   ```bash
   sudo systemctl stop gdm 2>/dev/null || true
   ```

   PortMaster handles EmulationStation itself. For a manual launch, the script stops and restarts
   EmulationStation when systemd is available.

7. Launch and inspect the log:

   ```bash
   cd /roms2/ports
   ./"Pokemon Reloaded.sh"
   tail -100 /roms2/ports/pokemonreloaded/log.txt
   ```

## Verification checklist

- `data/` exists and contains `audio/`, `partidas/`, etc.
- Exactly one game `.exe` exists at the port root (or `reloaded.exe`).
- `gm8emulator` reports `OpenGL ES` / Mali in the log.
- Audio works through ALSA; the game may print harmless invalid-WAV warnings.
- A save appears in `data/partidas/` and a backup appears in `saves-backup/`.
- Known issue: the right edge of some battle screens can be clipped; do not replace the centred
  binary with the `rightalign` build without testing.

## Do not

- Do not commit or upload `data/`, `*.exe`, saves, logs or screenshots containing game assets.
- Do not use `pkill -f` with the game name; it can kill the invoking shell.
- Do not bundle or replace system SDL2, libc, libEGL or Mali drivers.
- Do not claim the game is yours. Keep the F3R and Klisee credits.
