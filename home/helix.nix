{ helix, pkgs, ... }:
{
  programs.helix = {
    enable = true;

    package = helix.packages."${pkgs.system}".helix;

    extraPackages = with pkgs;
      [
        # lsps
        nodePackages.bash-language-server

        # lua-language-server

        marksman

        pyright
        python311Packages.python-lsp-server
        poetry

        taplo

        nil

        typst-lsp

        nodePackages.typescript-language-server
        vscode-langservers-extracted

        texlab
        ltex-ls

        nodePackages.svelte-language-server
        nodePackages.prettier
        nodePackages.vscode-langservers-extracted
        emmet-ls
        tailwindcss-language-server

        gopls
        golangci-lint
        golangci-lint-langserver

        # formatters
        black
        dprint
        nixpkgs-fmt
        typstfmt
      ];

    defaultEditor = true;

    settings = {
      theme = "catppuccin_latte";

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

        statusline = {
          left = [ "mode" "spinner" "version-control" "file-name" "read-only-indicator" "file-modification-indicator" ];
        };

        end-of-line-diagnostics = "hint";

        inline-diagnostics = {
          cursor-line = "warning";
          # other-lines = "warning";
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

        typst = {
          command = "typst-lsp";
          config = {
            exportPdf = "never";
          };
        };

        clangd.command = "/usr/bin/clangd";

        ltex = {
          command = "ltex-ls";
        };

        eslint = {
          command = "vscode-eslint-language-server";
          args = [ "--stdio" ];
          config = {
            validate = "on";
            experimental = {
              useFlatConfig = false;
            };
            rulesCustomizations = [ ];
            run = "onType";
            problems = {
              shortenToSingleLine = false;
            };
            nodePath = "";
            codeAction = {
              disableRuleComment = {
                enable = false;
              };
              showDocumentation.enable = true;
            };
            workingDirectories.mode = "auto";
            codeActionOnSave = {
              enable = true;
              mode = "all";
              "source.fixAll" = true;
            };
            lintTask = {
              enable = true;
            };
            format.enable = true;
          };
        };

        emmet-ls = {
          command = "emmet-ls";
          args = [ "--stdio" ];
        };

        tailwindcss-svelte = {
          language-id = "svelte";
          command = "tailwindcss-language-server";
          args = [ "--stdio" ];
        };

        tailwindcss-tsx = {
          language-id = "tsx";
          command = "tailwindcss-language-server";
          args = [ "--stdio" ];
        };

        tailwindcss-css = {
          language-id = "css";
          command = "tailwindcss-language-server";
          args = [ "--stdio" ];
        };

        tailwindcss-html = {
          language-id = "html";
          command = "tailwindcss-language-server";
          args = [ "--stdio" ];
        };
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
          auto-format = true;
          roots = [ "typst.toml" ];
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          formatter = {
            command = "typstfmt";
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
        {
          name = "svelte";
          auto-format = true;
          formatter = { command = "prettier"; args = [ "--parser" "svelte" ]; };
          language-servers = [
            {
              name = "svelteserver";
              except-features = [ "format" ];
            }
            "eslint"
            "emmet-ls"
            "tailwindcss-svelte"
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          formatter = { command = "prettier"; args = [ "--parser" "typescript" ]; };
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "eslint"
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          formatter = { command = "prettier"; args = [ "--parser" "typescript" ]; };
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "eslint"
            "emmet-ls"
            "tailwindcss-tsx"
          ];
        }
        {
          name = "html";
          auto-format = true;
          formatter = { command = "prettier"; args = [ "--parser" "html" ]; };
          language-servers = [
            {
              name = "vscode-html-language-server";
              except-features = [ "format" ];
            }
            "eslint"
            "emmet-ls"
            "tailwindcss-html"
          ];
        }
        {
          name = "json";
          auto-format = true;
          formatter = { command = "prettier"; args = [ "--parser" "json" ]; };
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
            "eslint"
          ];
        }
        {
          name = "css";
          auto-format = true;
          file-types = [ "css" "postcss" ];
          language-servers = [ "tailwindcss-css" "vscode-css-language-server" ];
        }
      ];
    };
  };
}
