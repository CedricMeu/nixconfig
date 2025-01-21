{ pkgs, ... }:
{
  programs.helix = {
    enable = true;

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

        tinymist

        nodePackages.typescript-language-server
        vscode-langservers-extracted

        texlab
        ltex-ls

        efm-langserver
        nodePackages.svelte-language-server
        nodePackages.prettier
        nodePackages.vscode-langservers-extracted
        emmet-ls
        tailwindcss-language-server

        # formatters
        black
        dprint
        nixpkgs-fmt
        typstfmt
      ];

    defaultEditor = true;

    settings = {
      theme = "ayu_light";

      editor = {
        line-number = "relative";
        mouse = true;
        bufferline = "always";
        color-modes = true;
        auto-save = true;
        scroll-lines = 3;
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

          W = "move_next_sub_word_start";
          B = "move_prev_sub_word_start";
          E = "move_next_sub_word_end";

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

            t = {
              t = ":tree-sitter-subtree";
              a = "select_all_siblings";
              h = "select_prev_sibling";
              l = "select_next_sibling";
              j = "select_all_children";
              k = [ "extend_parent_node_start" "extend_parent_node_end" ];
            };
          };
        };

        select = {
          W = "move_next_sub_word_start";
          B = "move_prev_sub_word_start";
          E = "move_next_sub_word_end";
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
          command = "tinymist";
        };

        clangd.command = "/usr/bin/clangd";

        ltex = {
          command = "ltex-ls";
        };

        typescript-language-server = {
          command = "typescript-language-server";
          args = [ "--stdio" ];
          config = {
            hostInfo = "helix";
            typescript.inlayHints = {
              includeInlayEnumMemberValueHints = true;
              includeInlayFunctionLikeReturnTypeHints = false;
              includeInlayFunctionParameterTypeHints = false;
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = false;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayVariableTypeHints = true;
            };
          };
        };

        efm-lsp-prettier = {
          command = "efm-langserver";
          config = {
            documentFormatting = true;
            languages = pkgs.lib.genAttrs [ "typescript" "javascript" "typescriptreact" "javascriptreact" "vue" "json" "markdown" ] (_: [{
              formatCommand = "prettier --stdin-filepath \${INPUT}";
              formatStdin = true;
            }]);
          };
        };

        # eslint = {
        #   command = "vscode-eslint-language-server";
        #   args = [ "--stdio" ];
        #   roots = [ "eslint.config.mjs" ];
        #   config = {
        #     validate = "on";
        #     packageManager = "yarn";
        #     useESLintClass = false;
        #     codeActionOnSave = {
        #       enable = true;
        #       mode = "fixAll";
        #       # mode = "all";
        #     };
        #     format = true;
        #     quiet = false;
        #     onIgnoredFiles = "off";
        #     rulesCustomizations = [ ];
        #     run = "onType";
        #     nodePath = "";
        #     workingDirectory.mode = "location";
        #     experimental = {
        #       useFlatConfig = true;
        #     };
        #     problems.shortenToSingleLine = false;
        #     codeAction = {
        #       disableRuleComment = {
        #         enable = true;
        #         location = "separateLine";
        #       };
        #       showDocumentation.enable = true;
        #     };
        #   };
        # };

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
          language-servers = [
            "typst"
            # "ltex" 
          ];
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
          # formatter = { command = "prettier"; args = [ "--parser" "typescript" ]; };
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "eslint"
            { name = "efm-lsp-prettier"; only-features = [ "format" ]; }
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          # formatter = { command = "prettier"; args = [ "--parser" "typescript" ]; };
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "eslint"
            "emmet-ls"
            "tailwindcss-tsx"
            { name = "efm-lsp-prettier"; only-features = [ "format" ]; }
          ];
        }
        {
          name = "html";
          auto-format = true;
          formatter = { command = "prettier"; args = [ "--parser" "html" ]; };
          language-servers = [
            "vscode-html-language-server"
            "emmet-ls"
            "tailwindcss-html"
          ];
        }
        {
          name = "json";
          auto-format = true;
          # formatter = { command = "prettier"; args = [ "--parser" "json" ]; };
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
            "eslint"
            { name = "efm-lsp-prettier"; only-features = [ "format" ]; }
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
