# Configuration using Nix

## Configuration Structure

- `apps/` holds declarations for the apps to be installed.
- `home/` holds home-manager configuration.
- `hosts/` holds a configuration for each host.
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
