#!/usr/bin/env bash
set -euo pipefail

mode="${ARCH_SMOKE_MODE:-full}"
real_yay="${ARCH_SMOKE_REAL_YAY:-0}"

case "$mode" in
  full|system)
    ;;
  *)
    echo "ARCH_SMOKE_MODE must be 'full' or 'system', got: ${mode}" >&2
    exit 2
    ;;
esac

if grep -q '^#DisableSandbox' /etc/pacman.conf; then
  sed -i 's/^#DisableSandbox/DisableSandbox/' /etc/pacman.conf
elif ! grep -q '^DisableSandbox' /etc/pacman.conf; then
  printf '\nDisableSandbox\n' >>/etc/pacman.conf
fi

pacman -Sy --needed --noconfirm ansible sudo

useradd -m -s /bin/bash smoke
install -d -m 0755 /etc/sudoers.d
printf 'smoke ALL=(ALL:ALL) NOPASSWD: ALL\n' >/etc/sudoers.d/smoke
chmod 0440 /etc/sudoers.d/smoke

if [[ "$mode" == "full" && "$real_yay" != "1" ]]; then
  install -d -m 0755 /usr/local/bin
  cat >/usr/local/bin/yay <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
exec sudo pacman "$@"
EOF
  chmod 0755 /usr/local/bin/yay
fi

ansible_args=(
  -i /repo/bootstrap/inventory.ini
  /repo/bootstrap/playbook.yml
)

if [[ "$mode" == "full" ]]; then
  ansible_args+=(
    -e arch_package_file=/repo/bootstrap/smoke/arch-packages.txt
  )
  if [[ "$real_yay" != "1" ]]; then
    ansible_args+=(
      -e bootstrap_yay=false
    )
  fi
else
  ansible_args+=(--tags system)
fi

sudo -u smoke \
  env HOME=/home/smoke ANSIBLE_LOCAL_TEMP=/tmp/ansible-local TMPDIR=/tmp \
  ansible-playbook "${ansible_args[@]}"

test -x /etc/acpi/brightness.sh
test -f /etc/acpi/events/brightness
test -f /etc/greetd/config.toml
test -f /etc/greetd/regreet.toml

if [[ "$mode" == "full" ]]; then
  command -v yay >/dev/null
  pacman -Q git >/dev/null
  pacman -Q jq >/dev/null
fi
