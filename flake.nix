{
  description = "Nix for macOS configuration";

  # the nixConfig here only affects the flake itself, not the system configuration!
  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    tree-sitter-typst = {
      url = "github:frozolotl/tree-sitter-typst";
      flake = false;
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixpkgs-unstable
    , flake-parts
    , home-manager
    , darwin
    , tree-sitter-typst
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      let
        username = "cedricmeukens";
        useremail = "cedric.meukens@icloud.com";
      in
      {
        systems = [
          "x86_64-darwin"
        ];

        flake = {
          darwinConfigurations = (
            import ./hosts/macbook-2015
              {
                inherit inputs nixpkgs nixpkgs-unstable home-manager darwin username useremail tree-sitter-typst;
              }
            //
            import ./hosts/macbook-2017
              {
                inherit inputs nixpkgs nixpkgs-unstable home-manager darwin username useremail tree-sitter-typst;
              }
          );
        };

        perSystem = { pkgs, ... }: {
          devShells.default =
            pkgs.mkShell {
              name = "nixconfig";
              nativeBuildInputs = with pkgs;
                [
                  just
                ];
            };

          formatter = pkgs.nixpkgs-fmt;
        };
      }
    );
}
