switch: check fmt
  darwin-rebuild switch --flake .

build: check fmt
  darwin-rebuild build --flake .

rollback:
  darwin-rebuild --rollback

# setup: check fmt 
#   nix build .#darwinConfigurations.{{host}}.system --extra-experimental-features nix-command --extra-experimental-features flakes 

update:
  nix flake update

history:
  nix profile history --profile /nix/var/nix/profiles/system

gc:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
  sudo nix store gc

check:
  nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes

fmt:
  # format the nix files in this repo
  nix fmt --extra-experimental-features nix-command --extra-experimental-features flakes

clean:
  rm -rf result
