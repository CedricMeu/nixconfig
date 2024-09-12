# Configuration using Nix

## Configuration Structure

```bash
 .
├──  apps
│  ├──  personal.nix
│  └──  work.nix
├── 󱂵 home
│  ├──  cargo
│  │  ├──  cargo.nix
│  │  └──  cargo.toml
│  ├──  alacritty.nix
│  ├──  core.nix
│  ├──  default.nix
│  ├──  git.nix
│  ├──  helix.nix
│  ├──  kitty.nix
│  ├──  shell.nix
│  ├──  starship.nix
│  └──  vscode.nix
├──  hosts
│  ├──  common
│  │  ├──  darwin
│  │  │  ├──  configuration.nix
│  │  │  ├──  default.nix
│  │  │  └──  system.nix
│  │  ├──  default.nix
│  │  ├──  nix-core.nix
│  │  └──  system.nix
│  ├──  macbook-2015
│  │  └──  default.nix
│  ├──  macbook-2017
│  │  └──  default.nix
│  └──  macbook-gs
│     └──  default.nix
├──  flake.lock
├──  flake.nix
├──  justfile
└──  README.md
```

- `apps/` holds configurations for applications separated by setting, one configuration for work, one for personal use.
- `home/` holds home-manager configuration (dotfiles).
- `hosts/` holds a configuration for each host. This configuration includes the `home/`, `hosts/common`, and `hosts/common/darwin` (if that host happens to be on macOS) modules.
- `hosts/common/` holds common configuration for all hosts.
- `hosts/common/darwin` holds common configuration for all macOS hosts.

## Setup

1. Install nix using the [determinate nix installer](https://github.com/DeterminateSystems/nix-installer).
1. Install [Homebrew](https://brew.sh).
1. Alter `username` and `useremail` in `flake.nix`, note that `macbook-gs` has the `username` and `useremail` overridden.
1. Describe your host under `hosts/`.
1. Add your host in `flake.nix` under `darwinConfigurations`.
1. Build the flake with `nix build .#darwinConfigurations.$(hostname).system --extra-experimental-features nix-command --extra-experimental-features flakes`. If another hostname is to be used than currently set, replace `$(hostname)` with that name.
1. Restart your terminal
1. In this repo, run `echo "use flake" > .envrc` and then `direnv allow` once. This will start a dev shell with all needed tooling every time you `cd` into the folder.

## Applying

Simply run `darwin-rebuild switch --flake .` to apply the configuration.

## Other

Some useful commands are provided in a justfile.
