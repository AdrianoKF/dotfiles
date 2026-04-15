# Machine Bootstrap

This directory owns machine-level setup that does not fit Dotbot's symlink model:

- Arch package installation from `packages/arch.txt`
- `yay` bootstrap when it is missing
- Linux system files under `/etc`

Dotbot still owns home-directory links such as shell, editor, terminal, and desktop
configuration.

## Run

Install Ansible first, then run from the repository root:

```sh
ansible-playbook -i bootstrap/inventory.ini bootstrap/playbook.yml --ask-become-pass
```

To run a subset:

```sh
ansible-playbook -i bootstrap/inventory.ini bootstrap/playbook.yml --ask-become-pass --tags packages
ansible-playbook -i bootstrap/inventory.ini bootstrap/playbook.yml --ask-become-pass --tags system
ansible-playbook -i bootstrap/inventory.ini bootstrap/playbook.yml --ask-become-pass --tags acpi
ansible-playbook -i bootstrap/inventory.ini bootstrap/playbook.yml --ask-become-pass --tags greetd
```

If you run from inside `bootstrap/`, `ansible.cfg` supplies the local inventory
and sudo prompt defaults:

```sh
cd bootstrap
ansible-playbook playbook.yml
```

For home-directory dotfiles only, keep using Dotbot directly:

```sh
dotbot/bin/dotbot -d "$PWD" -c install.conf.yaml
```

The top-level `./install` script still reflects the pre-split behavior for now.

## Arch Smoke Test

The smoke test starts an Arch Linux Docker container, installs Ansible inside it,
mounts this repository read-only, and applies the playbook to the container.

Full mode uses a tiny package fixture from `bootstrap/smoke/arch-packages.txt`
and a `yay` shim backed by `pacman`. This applies the package and system paths
without installing the full desktop package list or compiling an AUR helper:

```sh
bootstrap/smoke-arch.sh
```

For a faster check of just the privileged `/etc` file tasks:

```sh
bootstrap/smoke-arch.sh system
```

Set `ARCH_SMOKE_IMAGE` to test a different Arch image:

```sh
ARCH_SMOKE_IMAGE=archlinux:base-devel bootstrap/smoke-arch.sh
```

The official `archlinux` image is currently x86_64-only for this use case, so
the smoke driver defaults to `--platform linux/amd64`. Override it if your image
supports another platform:

```sh
ARCH_SMOKE_PLATFORM=linux/amd64 bootstrap/smoke-arch.sh system
```

The driver also defaults to `--security-opt seccomp=unconfined` because pacman
can fail under Docker's default seccomp profile in emulated containers.

To test the real `yay` bootstrap path, use `real-yay`. This is best on native
x86_64; under amd64 emulation on Apple Silicon, the Go compiler used by `yay`
can fail independently of this playbook.

```sh
bootstrap/smoke-arch.sh real-yay
```
