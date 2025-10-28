{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}:
let
  config_file = builtins.readFile ./config.nu;
in
{
  # Abusing fish for it's completions
  programs.fish.enable = true;

  programs.nushell = {
    enable = true;
    extraConfig = config_file;

    extraEnv = lib.optionalString (osConfig ? environment) ''
      # Copy over env variables from nix definitions
      load-env ${builtins.toJSON osConfig.environment.variables}

      # Fix editor
      $env.EDITOR = "${pkgs.helix}/bin/hx"

      # Fix system path
      $env.PATH = "${
        builtins.replaceStrings
          [
            "$USER"
            "$HOME"
          ]
          [
            config.home.username
            config.home.homeDirectory
          ]
          osConfig.environment.systemPath
      }"

      mkdir ~/.cache/carapace
      carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
    '';
  };
}
