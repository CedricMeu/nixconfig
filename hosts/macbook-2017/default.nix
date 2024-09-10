{ inputs
, home-manager
, darwin
, username
, useremail
, ...
}:
let
  system = "x86_64-darwin";
  hostname = "macbook-2017";

  specialArgs = inputs // {
    inherit username useremail hostname;
  };
in
{
  "${hostname}" = darwin.lib.darwinSystem
    {
      inherit system specialArgs;

      modules = [
        ../common
        ../common/darwin

        ../../apps/personal.nix

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
