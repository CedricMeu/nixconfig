{
  description = "Nix for macOS configuration";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-vsc-lang-servers.url = "github:nixos/nixpkgs/c1c760a1f23ac5d2df75117df032d8ddcdb9affd";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      # url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:CedricMeu/helix/better-bufferline";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    vscoqls = {
      url = "github:coq/vscoq/v2.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-vsc-lang-servers,
      flake-utils,
      devshell,
      home-manager,
      darwin,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlays.default
          ];
        };
      in
      {

        devShell = pkgs.devshell.mkShell {
          name = "cfg";

          commands = [
            {
              help = "Switch to new configuration";
              name = "switch";
              command = "darwin-rebuild switch --flake .";
            }
            {
              help = "Build new configuration";
              name = "build";
              command = "darwin-rebuild build --flake .";
            }
            {
              help = "Rollback to previous version";
              name = "rollback";
              command = "darwin-rebuild --rollback";
            }
            {
              help = "Garbage collection";
              name = "gc";
              command = "
                sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
                sudo nix store gc
              ";
            }
            {
              help = "Show history";
              name = "history";
              command = "nix profile history --profile /nix/var/nix/profiles/system";
            }
          ];
        };

        formatter = pkgs.nixpkgs-fmt;
      }
    )
    // {
      darwinConfigurations = (
        import ./hosts/macbook-gs {
          inherit
            self
            inputs
            nixpkgs
            nixpkgs-vsc-lang-servers
            home-manager
            darwin
            ;
          username = "cedric.meukens";
          useremail = "cedric.meukens@guardsquare.com";
        }
      );
    };
}
