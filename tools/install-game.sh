#!/bin/bash
set -euo pipefail

usage() {
    cat <<'EOF'
Uso:
  install-game.sh <zip-oficial> [carpeta-del-port]

Ejemplo:
  ./tools/install-game.sh "/ruta/Proyecto Reloaded The Last Beta 1.9.2.2 Full.zip" \
    /roms2/ports/pokemonreloaded
EOF
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ] || [ $# -lt 1 ]; then
    usage
    exit 0
fi

GAME_ZIP="$1"
PORT_DIR="${2:-/roms2/ports/pokemonreloaded}"

if [ ! -f "$GAME_ZIP" ]; then
    echo "No existe el zip: $GAME_ZIP" >&2
    exit 1
fi

if [ ! -d "$PORT_DIR" ]; then
    echo "No existe la carpeta del port: $PORT_DIR" >&2
    exit 1
fi

if ! command -v unzip >/dev/null 2>&1; then
    echo "Falta unzip. Instálalo o descomprime el juego a mano." >&2
    exit 1
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Extrayendo el juego..."
unzip -q "$GAME_ZIP" -d "$tmp"

SRC=""
if [ -d "$tmp/data" ]; then
    SRC="$tmp"
else
    while IFS= read -r candidate; do
        if [ -d "$candidate/data" ]; then
            SRC="$candidate"
            break
        fi
    done < <(find "$tmp" -maxdepth 3 -type d -print)
fi

if [ -z "$SRC" ] || [ ! -d "$SRC/data" ]; then
    echo "No encontré la carpeta data/ dentro del zip." >&2
    exit 1
fi

echo "Copiando data/ a $PORT_DIR ..."
mkdir -p "$PORT_DIR/data"
cp -a "$SRC/data/." "$PORT_DIR/data/"

echo "Copiando el ejecutable del juego..."
found=0
while IFS= read -r exe; do
    cp -a "$exe" "$PORT_DIR/"
    found=1
done < <(find "$SRC" -maxdepth 1 -type f -iname '*.exe' -print)

if [ "$found" -eq 0 ]; then
    echo "Aviso: no encontré ningún .exe; copia el ejecutable original a mano." >&2
fi

chmod +x "$PORT_DIR/gm8emulator" 2>/dev/null || true
chmod +x "$PORT_DIR"/*.sh 2>/dev/null || true

echo
echo "Listo. Contenido esperado en $PORT_DIR:"
echo "  data/  *.exe  gm8emulator  run.sh  assets/"
echo "No se han subido datos del juego a GitHub."
