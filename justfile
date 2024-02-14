# just is a command runner, Justfile is very similar to Makefile, but simpler.

host := "$(hostname)"


check:
  nix flake check

build:
  nix build .#darwinConfigurations.{{host}}.system --no-eval-cache

switch: build
  ./result/sw/bin/darwin-rebuild switch --flake .#{{host}}

update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

  # garbage collect all unused nix store entries
  sudo nix store gc --debug

fmt:
  # format the nix files in this repo
  nix fmt

clean:
  rm -rf result
