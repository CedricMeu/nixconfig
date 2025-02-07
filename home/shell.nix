{ pkgs, ... }: {
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    fzf =
      let
        catppuccin-late = {
          "bg+" = "#ccd0da";
          "bg" = "#eff1f5";
          "spinner" = "#dc8a78";
          "hl" = "#d20f39";
          "fg" = "#4c4f69";
          "header" = "#d20f39";
          "info" = "#8839ef";
          "pointer" = "#dc8a78";
          "marker" = "#7287fd";
          "fg+" = "#4c4f69";
          "prompt" = "#8839ef";
          "hl+" = "#d20f39";
          "selected-bg" = "#bcc0cc";
        };
      in
      {
        enable = true;
        colors = catppuccin-late;
        enableZshIntegration = true;
        defaultOptions = [
          "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
        ];
      };

    zsh = {
      enable = true;
      enableCompletion = true;

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "b06e7574577cd729c629419a62029d31d0565a7a";
            sha256 = "8a551abc021698b88c8763ee9ad12b302a4e711ef564c95090a8553930dd1d9c";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
            sha256 = "e2b5b637e6a79001f8b00e926b99abf482ac74083b59382b9b2a89d95d6fca04";
          };
        }
        {
          name = "forgit";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "forgit";
            rev = "00ed721ece5156aab7795ae885593f9f8582b0cc";
            sha256 = "5ded6dbf8673468572b62ce1a8a4303b2750f48d1da9e36722ef6ccc7e33038c";
          };
        }
      ];
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
          file = "Catppuccin-latte.tmTheme";
        };
      };
    };

    atuin = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}

