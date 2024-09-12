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
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nurpkgs.url = "github:CedricMeu/nur-packages";
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , flake-parts
    , home-manager
    , darwin
    , nurpkgs
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
          "aarch64-darwin"
        ];

        flake = {
          darwinConfigurations = (
            import ./hosts/macbook-2015
              {
                inherit self inputs nixpkgs nurpkgs home-manager darwin username useremail;
              }
            //
            import ./hosts/macbook-2017
              {
                inherit self inputs nixpkgs nurpkgs home-manager darwin username useremail;
              }
            //
            import ./hosts/macbook-gs
              {
                inherit self inputs nixpkgs nurpkgs home-manager darwin;
                username = "cedric.meukens";
                useremail = "cedric.meukens@guardsquare.com";
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
