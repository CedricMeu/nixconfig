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

        $env.config.color_config = {
          # color for nushell primitives
          separator: dark_gray
          leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
          header: green_bold
          empty: blue
          # Closures can be used to choose colors for specific values.
          # The value (in this case, a bool) is piped into the closure.
          # eg) {|| if $in { 'dark_cyan' } else { 'dark_gray' } }
          bool: dark_cyan
          int: dark_gray
          filesize: cyan_bold
          duration: dark_gray
          date: purple
          range: dark_gray
          float: dark_gray
          string: dark_gray
          nothing: dark_gray
          binary: dark_gray
          cell-path: dark_gray
          row_index: green_bold
          record: dark_gray
          list: dark_gray
          block: dark_gray
          hints: dark_gray
          search_result: { fg: white bg: red }
          shape_and: purple_bold
          shape_binary: purple_bold
          shape_block: blue_bold
          shape_bool: light_cyan
          shape_closure: green_bold
          shape_custom: green
          shape_datetime: cyan_bold
          shape_directory: cyan
          shape_external: cyan
          shape_externalarg: green_bold
          shape_external_resolved: light_purple_bold
          shape_filepath: cyan
          shape_flag: blue_bold
          shape_float: purple_bold
          # shapes are used to change the cli syntax highlighting
          shape_garbage: { fg: white bg: red attr: b }
          shape_glob_interpolation: cyan_bold
          shape_globpattern: cyan_bold
          shape_int: purple_bold
          shape_internalcall: cyan_bold
          shape_keyword: cyan_bold
          shape_list: cyan_bold
          shape_literal: blue
          shape_match_pattern: green
          shape_matching_brackets: { attr: u }
          shape_nothing: light_cyan
          shape_operator: yellow
          shape_or: purple_bold
          shape_pipe: purple_bold
          shape_range: yellow_bold
          shape_record: cyan_bold
          shape_redirection: purple_bold
          shape_signature: green_bold
          shape_string: green
          shape_string_interpolation: cyan_bold
          shape_table: blue_bold
          shape_variable: purple
          shape_vardecl: purple
          shape_raw_string: light_purple
        }

        $env.config.completions.external = {
          enable: true
          completer: $external_completer
        }

        $env.config.show_banner = false

        alias nu-open = open
        alias open = ^open
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

    atuin = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}

