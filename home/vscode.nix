{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    # Disabled to develop an extension:
    package = pkgs.vscodium;
    # mutableExtensionsDir = false;
    enableExtensionUpdateCheck = false;

    # For next version
    # profiles.default = {
    enableUpdateCheck = false;

    extensions =
      with pkgs.vscode-extensions;
      [
        visualstudioexptteam.vscodeintellicode
        visualstudioexptteam.intellicode-api-usage-examples

        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        teabyii.ayu
        mkhl.direnv

        ms-python.python
        ms-toolsai.jupyter

        tamasfe.even-better-toml

        maximedenes.vscoq

        golang.go

        ms-azuretools.vscode-docker

        dbaeumer.vscode-eslint
      ]
      ++ (with pkgs.open-vsx; [
        vitest.explorer
      ]);

    userSettings = {
      "workbench.colorTheme" = "Ayu Light";
      "workbench.iconTheme" = "ayu";

      "files.autoSave" = "afterDelay";

      "terminal.integrated.fontFamily" =
        "CaskaydiaCove Nerd Font Mono, Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";

      "editor.fontFamily" =
        "CaskaydiaCove Nerd Font Mono, Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
      "editor.fontSize" = 12;
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;

      "extensions.ignoreRecommendations" = true;
      "extensions.experimental.affinity"."jasew.vscode-helix-emulation" = 1;
      "eslint.useFlatConfig" = true;

      "terminal.integrated.profiles.osx" = {
        "nu" = {
          "path" = "${pkgs.nushell}/bin/nu";
          "args" = [ ];
        };
      };
      "terminal.integrated.defaultProfile.osx" = "nu";
    };
  };
  # };
}
