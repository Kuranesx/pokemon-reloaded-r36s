# Building the R36S binary

This source snapshot is OpenGMK plus the changes used by the Pokémon Reloaded R36S port.

## Requirements

- Rust stable with the `aarch64-unknown-linux-gnu` target
- Zig C compiler wrappers (`zigcc`, `zigcxx`, `ziglink`) in `$HOME/opt`
- The target device's SDL2 headers/libraries, or an equivalent aarch64 sysroot

The published binary was linked against the ArkOS glibc 2.30 environment. Build with a matching
sysroot if you need it to run on the same firmware.

## Build

```bash
./build-r36s.sh
```

The output is:

```text
target-zig230/aarch64-unknown-linux-gnu/release/gm8emulator
```

The source layout expects `vendor/ramen` and `vendor/udon` next to `src/`, as in this archive.
The build uses the `sdl` feature only (`--no-default-features --features sdl`).
