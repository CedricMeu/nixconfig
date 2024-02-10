{ pkgs, ... }: {
  programs.helix = {
    enable = true;

    defaultEditor = true;

    extraPackages = with pkgs; [
      # lsps
      nodePackages.bash-language-server
      lua-language-server

      marksman

      pyright
      python311Packages.python-lsp-server

      taplo

      nil

      typst-lsp

      nodePackages.typescript-language-server
      vscode-langservers-extracted

      rust-analyzer

      texlab
      ltex-ls

      # formatters
      black
      dprint
      nixpkgs-fmt
      typstfmt
    ];

    settings = {
      theme = "catppuccin_macchiato";

      editor = {
        line-number = "relative";
        mouse = true;
        bufferline = "always";
        color-modes = true;
        auto-save = true;
        scroll-lines = 1;
        true-color = true;
        idle-timeout = 50;
        undercurl = true;

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };

        soft-wrap = {
          enable = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
        };

        indent-guides = {
          render = true;
        };
      };

      keys = {
        normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];

          C-h = "jump_view_left";
          C-j = "jump_view_down";
          C-k = "jump_view_up";
          C-l = "jump_view_right";

          X = [ "extend_line_above" ];
          A-x = [ "extend_line_below" "extend_visual_line_up" "extend_visual_line_up" "extend_to_line_bounds" ];
          A-X = [ "extend_line_above" "extend_visual_line_down" "extend_visual_line_down" "extend_to_line_bounds" ];

          C-a = "goto_line_start";
          C-e = "goto_line_end";

          space = {
            space = "command_palette";

            w = {
              n = "vsplit";
              d = "hsplit";
            };

            c = {
              s = ":w";
              S = ":wa";
              q = ":bc";
            };
          };
        };

        insert = {
          j = {
            j = "normal_mode";
          };

          C-p = "move_line_up";
          C-n = "move_line_down";
          C-e = "goto_line_end_newline";
          C-a = "goto_line_start";
          C-f = "move_char_right";
          C-b = "move_char_left";
        };
      };
    };

    languages = {
      language-server = {
        pylsp.command = "pylsp";

        pyright = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
        };

        ruff.command = "ruff-lsp";

        typst.command = "typst-lsp";

        clangd.command = "clangd";

        ltex.command = "ltex-ls";
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixpkgs-fmt";
          };
          language-servers = [ "nil" ];
        }
        {
          name = "python";
          auto-format = true;
          formatter = {
            command = "black";
            args = [ "--quiet" "-" ];
          };
          language-servers = [ "pyright" "ruff" ];
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = [ "rust-analyzer" ];
        }
        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = "taplo";
            args = [ "fmt" "-" ];
          };
          language-servers = [ "taplo" ];
        }
        {
          name = "cpp";
          auto-format = true;
          language-servers = [ "clangd" ];
        }
        {
          name = "typst";
          scope = "source.typst";
          auto-format = true;
          injection-regex = "typst";
          file-types = [ "typ" "typst" ];
          comment-token = "//";
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          auto-pairs = {
            "(" = ")";
            "{" = "}";
            "[" = "]";
            "\"" = "\"";
            "`" = "`";
            "$" = "$";
          };
          roots = [ "typst.toml" ];
          formatter = {
            command = "typst-fmt";
            args = [ "/dev/stdin" "-o" "/dev/stdout" ];
          };
          language-servers = [ "typst" "ltex" ];
        }
        {
          name = "latex";
          auto-format = true;
          language-servers = [ "texlab" "ltex" ];
        }
        {
          name = "markdown";
          auto-format = true;
          formatter = {
            command = "dprint";
            args = [ "fmt" "--stdin" "md" ];
          };
          language-servers = [ "marksman" "ltex" ];
        }
      ];
    };
  };
}
