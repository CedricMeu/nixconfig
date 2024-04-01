# Configuration using Nix

## Configuration Structure

```bash
.
├── common
│  ├── apps.nix
│  ├── default.nix
│  ├── nix-core.nix
│  └── system.nix
├── darwin
│  ├── apps.nix
│  ├── configuration.nix
│  ├── default.nix
│  └── system.nix
├── flake.lock
├── flake.nix
├── home
│  ├── cargo.nix
│  ├── cargo.toml
│  ├── core.nix
│  ├── default.nix
│  ├── git.nix
│  ├── helix.nix
│  ├── kitty.nix
│  ├── shell.nix
│  ├── starship.nix
│  └── vscode.nix
├── hosts
│  ├── macbook-2015
│  │  └── default.nix
│  └── macbook-2017
│     └── default.nix
├── justfile
└── README.md

```

- `./common` holds configuration that might be shared between Darwin and other OSes.

- `./darwin` holds configuration that is specific to Darwin.

- `./home` holds home-manager configuration (dotfiles).

- `./hosts` holds a configuration for each host. This configuration points towards `./home`, `./common`, and `./darwin` if that host happens to be on macOS.

## Setup

1. Install nix using the [determinate nix installer](https://github.com/DeterminateSystems/nix-installer).
2. Install [Homebrew](https://brew.sh).
3. Alter `username` and `useremail` in `flake.nix`, and describe your host under `hosts/`
4. Install this flake `nix develop --extra-experimental-features nix-command --extra-experimental-features flakes -c just`.
5. Restart your terminal
7. In this repo, run `echo "use flake" > .envrc` and then `direnv allow` once.

From here on the devshell should be automatically loaded when entering the folder.
Here you can use `just` to interact with the flake.
The default target builds and switches configurations.
