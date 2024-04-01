{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    extensions =
      with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        mkhl.direnv

        ms-python.python
        ms-toolsai.jupyter

        tamasfe.even-better-toml
      ];

    userSettings =
      {
        "workbench.colorTheme" = "Catppuccin Latte";
        "workbench.iconTheme" = "catppuccin-Latte";

        "files.autoSave" = "afterDelay";

        "terminal.integrated.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
        "editor.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
        "editor.fontSize" = 10;
        "editor.fontLigatures" = true;
        "extensions.ignoreRecommendations" = true;
      };
  };
}
