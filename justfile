# just is a command runner, Justfile is very similar to Makefile, but simpler.

host := "$(hostname)"

switch: build
  ./result/sw/bin/darwin-rebuild switch --flake .#{{host}}

build: check fmt
  nix build .#darwinConfigurations.{{host}}.system --no-eval-cache

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

upgrade: && switch
  git pull
