{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    enableUpdateCheck = false;

    enableExtensionUpdateCheck = false;

    extensions =
      with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        mkhl.direnv

        ms-python.python
        ms-toolsai.jupyter
      ];

    userSettings =
      {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";

        "files.autoSave" = "afterDelay";

        "terminal.integrated.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
        "editor.fontFamily" = "Monoid Nerd Font Mono, Menlo, Monaco, 'Courier New', monospace";
        "editor.fontSize" = 10;
        "editor.fontLigatures" = true;
      };
  };
}
