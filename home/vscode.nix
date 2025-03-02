{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    # Disabled to develop an extension:
    # package = pkgs.vscodium;
    # mutableExtensionsDir = false;
    # enableExtensionUpdateCheck = false;

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
        jasew.vscode-helix-emulation
        vitest.explorer
      ]);

    userSettings = {
      "workbench.colorTheme" = "Ayu Light";
      "workbench.iconTheme" = "ayu";

      "files.autoSave" = "afterDelay";

      "terminal.integrated.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
      "editor.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
      "editor.fontSize" = 10;
      "editor.fontLigatures" = true;
      "extensions.ignoreRecommendations" = true;
      "extensions.experimental.affinity"."jasew.vscode-helix-emulation" = 1;
      "eslint.useFlatConfig" = true;
    };
  };
}
