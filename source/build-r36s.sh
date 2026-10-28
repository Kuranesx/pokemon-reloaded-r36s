#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"

export PATH="$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$PATH"
export CC_aarch64_unknown_linux_gnu="${CC_aarch64_unknown_linux_gnu:-$HOME/opt/zigcc}"
export CXX_aarch64_unknown_linux_gnu="${CXX_aarch64_unknown_linux_gnu:-$HOME/opt/zigcxx}"
export CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER="${CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER:-$HOME/opt/ziglink}"
export CFLAGS_aarch64_unknown_linux_gnu="${CFLAGS_aarch64_unknown_linux_gnu:--O2}"
export CXXFLAGS_aarch64_unknown_linux_gnu="${CXXFLAGS_aarch64_unknown_linux_gnu:--O2}"
export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-$ROOT/target-zig230}"
export CARGO_BUILD_JOBS="${CARGO_BUILD_JOBS:-1}"

cd "$ROOT/src/OpenGMK"
exec cargo build --release -p gm8emulator --bin gm8emulator \
    --no-default-features --features sdl --target aarch64-unknown-linux-gnu
