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
  # Carapace for completions
  programs.carapace.enable = true;

  programs.nushell = {
    enable = true;

    # Use extraConfig to not override home-manager generated config
    extraConfig = config_file;

    # Use extraEnv to not override home-manager generated env
    extraEnv = lib.optionalString (osConfig ? environment) ''
      # Copy over env variables from nix definitions
      let nixEnv =  ${builtins.toJSON osConfig.environment.variables} | merge { EDITOR: "${pkgs.helix}/bin/hx", VISUAL: "${pkgs.helix}/bin/hx" }
      # Use all nixEnv settings, allowing overrides by the invoking shell/program
      $nixEnv | merge deep $env | select ...($nixEnv | columns) | load-env

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
    '';
  };
}
