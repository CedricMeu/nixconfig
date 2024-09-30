{ pkgs, lib, osConfig, config, helix, ... }: {
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

    zellij = {
      enable = true;
      # enableZshIntegration = true;
      settings = {
        theme = "catppuccin-latte";
        default_shell = "${pkgs.nushell}/bin/nu";
        copy_command = "pbcopy";
        copy_on_select = true;
        ui.pane_frames.rounded_corners = true;
        keybinds = {
          locked = {
            "unbind \"Ctrl g\"" = [ ];
            "bind \"Alt g\"" = {
              SwitchToMode = "Normal";
            };
          };

          move = {
            "bind \"Alt m\"" = { SwitchToMode = "Normal"; };
          };

          pane = {
            "bind \"Alt p\"" = { SwitchToMode = "Normal"; };
          };

          resize = {
            "bind \"Alt r\"" = { SwitchToMode = "Normal"; };
          };

          scroll = {
            "bind \"Alt s\"" = { SwitchToMode = "Normal"; };
          };

          session = {
            "bind \"Alt w\"" = { SwitchToMode = "Normal"; };
            "bind \"Alt s\"" = { SwitchToMode = "scroll"; };
          };

          tab = {
            "bind \"Alt t\"" = { SwitchToMode = "Normal"; };
          };

          "shared_except \"locked\"" = {
            "unbind \"Ctrl h\"" = [ ]; # was Move, now Alt-v
            "unbind \"Ctrl o\"" = [ ]; # was Session, now Alt-w
            "unbind \"Ctrl s\"" = [ ]; # was Scroll, now Alt-s
            "unbind \"Ctrl n\"" = [ ]; # was Resize, now Alt-z
            "unbind \"Ctrl p\"" = [ ]; # was Pane, now Alt-a
            "unbind \"Ctrl t\"" = [ ]; # was Tab, now Alt-b
            "unbind \"Ctrl g\"" = [ ]; # was Locked, now Alt-g
            "unbind \"Ctrl q\"" = [ ]; # was Quit, now Alt-q
            "bind \"Alt g\"" = { SwitchToMode = "locked"; };
            "bind \"Alt q\"" = { Quit = [ ]; };
            "bind \"Alt d\"" = { NewPane = "down"; };
            "bind \"Alt n\"" = { NewPane = "right"; };
            "bind \"Alt f\"" = {
              ToggleFloatingPanes = [ ];
            };
            "bind \"Alt 1\"" = { GoToTab = 1; };
            "bind \"Alt 2\"" = { GoToTab = 2; };
            "bind \"Alt 3\"" = { GoToTab = 3; };
            "bind \"Alt 4\"" = { GoToTab = 4; };
            "bind \"Alt 5\"" = { GoToTab = 5; };
            "bind \"Alt 6\"" = { GoToTab = 6; };
            "bind \"Alt 7\"" = { GoToTab = 7; };
            "bind \"Alt 8\"" = { GoToTab = 8; };
            "bind \"Alt 9\"" = { GoToTab = 9; };
            "bind \"Alt 0\"" = { GoToTab = 10; };
          };

          "shared_except \"tmux\"" = {
            "unbind \"Ctrl b\"" = [ ]; # was Tmux
          };

          "shared_except \"move\" \"locked\"" = {
            "bind \"Alt m\"" = { SwitchToMode = "move"; };
          };

          "shared_except \"pane\" \"locked\"" = {
            "bind \"Alt p\"" = { SwitchToMode = "pane"; };
          };

          "shared_except \"resize\" \"locked\"" = {
            "bind \"Alt r\"" = { SwitchToMode = "resize"; };
          };

          "shared_except \"scroll\" \"locked\"" = {
            "bind \"Alt s\"" = { SwitchToMode = "scroll"; };
          };

          "shared_except \"session\" \"locked\"" = {
            "bind \"Alt w\"" = { SwitchToMode = "session"; };
          };

          "shared_except \"tab\" \"locked\"" = {
            "bind \"Alt t\"" = { SwitchToMode = "tab"; };
          };
        };
      };
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

    nushell = {
      enable = true;
      envFile.text = lib.optionalString (osConfig ? environment) ''
        load-env ${builtins.toJSON osConfig.environment.variables}
        $env.EDITOR = "${helix.packages."${pkgs.system}".helix}/bin/hx"
        $env.PATH = "${builtins.replaceStrings
        [
            "$USER"
            "$HOME"
        ]
        [
            config.home.username
            config.home.homeDirectory
        ]
        osConfig.environment.systemPath}"

        let external_completer = {|spans|
          fish --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
        }

        $env.config.completions.external = {
          enable: true
          completer: $external_completer
        }
      '';
    };

    # Abusing fish for it's completions
    fish.enable = true;

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

    # eza = {
    #   enable = true;
    #   enableNushellIntegration = true;
    # };
  };

  home.shellAliases = {
    # ls = "eza --icons=always --group-directories-first";
    # ll = "eza --icons=always --group-directories-first -l";
    # lt = "eza --icons=always --group-directories-first --tree";
    # j = "just";
  };
}

