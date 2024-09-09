{ inputs
, home-manager
, darwin
, username
, useremail
, ...
}:
let
  system = "aarch64-darwin";
  hostname = "GS-CWQDNFNMVX";

  specialArgs = inputs // {
    inherit username useremail hostname;
  };
in
{
  "${hostname}" = darwin.lib.darwinSystem
    {
      inherit system specialArgs;

      modules = [
        ./apps.nix
        ../../darwin/system.nix
        ../../common/system.nix

        ../../darwin/configuration.nix

        ../../common/nix-core.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ../../home;
        }
      ];
    };
}
