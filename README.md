# Configuration using Nix

## Configuration Structure

```bash
 .
├──  apps
│   └──  work.nix
├── 󱂵 home
│   ├──  core.nix
│   ├──  default.nix
│   ├──  ghostty
│   │   ├──  config
│   │   └──  ghostty.nix
│   ├──  git.nix
│   ├──  helix.nix
│   ├──  nushell
│   │   ├──  config.nu
│   │   └──  nushell.nix
│   ├──  shell.nix
│   ├──  starship.nix
│   ├──  vscode.nix
│   └──  zellij.nix
├──  hosts
│   ├──  common
│   │   ├──  darwin
│   │   │   ├──  configuration.nix
│   │   │   ├──  default.nix
│   │   │   └──  system.nix
│   │   ├──  default.nix
│   │   ├──  nix-core.nix
│   │   └──  system.nix
│   └──  macbook-gs
│       ├──  default.nix
│       └──  system.nix
├──  flake.lock
├──  flake.nix
└── 󰂺 README.md
```

- `apps/` holds declarations for the apps to be installed.
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

Simply run `cfg switch` to apply the configuration.
