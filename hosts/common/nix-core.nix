{
  pkgs,
  lib,
  helix,
  nix-vscode-extensions,
  nixpkgs-vsc-lang-servers,
  ...
}:
let
  pkgs-vsc-lang-servers = import nixpkgs-vsc-lang-servers {
    system = pkgs.system;
  };
in
{
  # enable flakes globally
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowAliases = true;
  };

  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default

    (final: prev: {
      helix = helix.packages.${final.system}.default;
      vscode-langservers-extracted = pkgs-vsc-lang-servers.vscode-langservers-extracted;
    })
  ];

  nix.enable = false;

  nix.package = pkgs.nix;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault false;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Disable auto-optimise-store because of this issue:
  #   https://github.com/NixOS/nix/issues/7273
  # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
  nix.settings = {
    auto-optimise-store = false;
  };
}
