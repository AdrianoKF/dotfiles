#!/usr/bin/env bash
set -euo pipefail

mode="${1:-full}"
image="${ARCH_SMOKE_IMAGE:-archlinux:latest}"
platform="${ARCH_SMOKE_PLATFORM:-linux/amd64}"
security_opt="${ARCH_SMOKE_SECURITY_OPT:-seccomp=unconfined}"
container_mode="$mode"
real_yay=0

case "$mode" in
  full|system)
    ;;
  real-yay)
    container_mode=full
    real_yay=1
    ;;
  *)
    echo "Usage: $0 [full|system|real-yay]" >&2
    exit 2
    ;;
esac

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

docker run --rm --pull=missing \
  --platform "${platform}" \
  --security-opt "${security_opt}" \
  -e "ARCH_SMOKE_MODE=${container_mode}" \
  -e "ARCH_SMOKE_REAL_YAY=${real_yay}" \
  -v "${repo_root}:/repo:ro" \
  "${image}" \
  /repo/bootstrap/smoke/arch-container.sh
