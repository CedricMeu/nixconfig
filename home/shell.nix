{ pkgs, ... }: {
  programs = {
    zoxide =
      {
        enable = true;
        enableZshIntegration = true;
      };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      # enableFzfGit = true;
      # enableFzfHistory = true;
      # enableFzfCompletion = true;
      # enableAutosuggestions = true;
      # enableSyntaxHighlighting = true;

      # TODO
      #  - forgit
      #  - fzf-tab
      #  - syntax-highlighting
    };


    bat = {
      enable = true;
      config = {
        theme = "catppuccin";
      };
      themes = {
        catppuccin = {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "bat";
            rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
            hash = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
          };
          file = "Catppuccin-mocha.tmTheme";
        };
      };
    };

    eza.enable = true;
    htop.enable = true;
  };

  home.shellAliases = {
    j = "just";
    ls = "eza --icons=always --group-directories-first";
    ll = "ls -l";
    lt = "ls --tree";
  };
}
