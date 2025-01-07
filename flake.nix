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

    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";

    home-manager = {
      # url = "github:nix-community/home-manager/master";
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:CedricMeu/helix/better-bufferline";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscoqls = {
      url = "github:coq/vscoq/v2.2.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , flake-utils
    , devshell
    , home-manager
    , darwin
    , ...
    }:
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlays.default
          ];
        };
      in
      {

        devShell =
          pkgs.devshell.mkShell {
            name = "cfg";

            commands = [
              {
                help = "Update inputs";
                name = "update";
                command = "nix flake update";
              }
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
            ];
          };

        formatter = pkgs.nixpkgs-fmt;
      })
    // {
      darwinConfigurations = (
        import ./hosts/macbook-gs
          {
            inherit self inputs nixpkgs home-manager darwin;
            username = "cedric.meukens";
            useremail = "cedric.meukens@guardsquare.com";
          }
      );
    };
}
