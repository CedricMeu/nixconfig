# just is a command runner, Justfile is very similar to Makefile, but simpler.

default:
  @just --list

build name:
  nix build .#darwinConfigurations.{{name}}.system --no-eval-cache

switch name: (build name)
  ./result/sw/bin/darwin-rebuild switch --flake .#{{name}}

update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

  # garbage collect all unused nix store entries
  sudo nix store gc --debug

check:
  nix flake check

fmt:
  # format the nix files in this repo
  nix fmt

clean:
  rm -rf result
