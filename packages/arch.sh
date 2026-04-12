#!/bin/bash -eu

# --- ensure yay (AUR helper) is installed ---
if ! command -v yay >/dev/null 2>&1; then
  echo "[bootstrap] installing yay…"

  sudo pacman -Sy --needed --noconfirm git base-devel

  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT

  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  pushd "$tmpdir/yay" >/dev/null

  makepkg -si --noconfirm

  popd >/dev/null
fi

# --- install packages ---

# Read packages from `arch.txt` (one per line) from the same directory and install them using `yay`.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mapfile -t pkgs < <(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/arch.txt")
yay -S --needed --noconfirm "${pkgs[@]}"
