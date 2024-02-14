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

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      let
        username = "cedricmeukens";
        useremail = "cedric.meukens@icloud.com";

        specialArgs =
          inputs
          // {
            inherit username useremail;
          };

        hm-input = {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
        };
      in
      {
        systems = [
          "x86_64-darwin"
        ];

        flake = {
          darwinConfigurations = {
            macbook-2015 = darwin.lib.darwinSystem {
              inherit specialArgs;
              system = "x86_64-darwin";
              modules = [
                ./hosts/common
                ./hosts/macbook-2015

                # home manager
                home-manager.darwinModules.home-manager
                hm-input
              ];
            };

            macbook-2017 = darwin.lib.darwinSystem {
              inherit specialArgs;
              system = "x86_64-darwin";
              modules = [
                ./hosts/common
                ./hosts/macbook-2017

                # home manager
                home-manager.darwinModules.home-manager
                hm-input
              ];
            };
          };
        };

        perSystem = { pkgs, system, ... }: {
          devShells.default =
            pkgs.mkShell {
              name = "nixconfig";
              nativeBuildInputs = with pkgs;
                [
                  just
                ];
            };
        };
      }
    );
}
