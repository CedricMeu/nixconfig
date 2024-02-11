{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    extensions =
      with pkgs; [
        vscode-extensions.catppuccin.catppuccin-vsc
        vscode-extensions.catppuccin.catppuccin-vsc-icons
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
