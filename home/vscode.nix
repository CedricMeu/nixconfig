{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    extensions =
      with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        teabyii.ayu
        mkhl.direnv

        ms-python.python
        ms-toolsai.jupyter

        tamasfe.even-better-toml

        maximedenes.vscoq
      ];

    userSettings =
      {
        "workbench.colorTheme" = "Ayu Light";
        "workbench.iconTheme" = "ayu";

        "files.autoSave" = "afterDelay";

        "terminal.integrated.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
        "editor.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
        "editor.fontSize" = 10;
        "editor.fontLigatures" = true;
        "extensions.ignoreRecommendations" = true;
      };
  };
}
