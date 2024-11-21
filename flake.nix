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
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      # url = "github:nix-community/home-manager/release-24.05";
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
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , flake-parts
    , home-manager
    , darwin
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
                inherit self inputs nixpkgs home-manager darwin username useremail;
              }
            //
            import ./hosts/macbook-2017
              {
                inherit self inputs nixpkgs home-manager darwin username useremail;
              }
            //
            import ./hosts/macbook-gs
              {
                inherit self inputs nixpkgs home-manager darwin;
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
