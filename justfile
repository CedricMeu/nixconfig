# just is a command runner, Justfile is very similar to Makefile, but simpler.

host := "$(hostname)"

switch: build
  ./result/sw/bin/darwin-rebuild switch --flake .#{{host}}

build: check fmt 
  nix build .#darwinConfigurations.{{host}}.system --extra-experimental-features nix-command --extra-experimental-features flakes 

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
  nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes

fmt:
  # format the nix files in this repo
  nix fmt --extra-experimental-features nix-command --extra-experimental-features flakes

clean:
  rm -rf result

upgrade: && switch
  git pull
