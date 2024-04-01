{ pkgs, nixpkgs-unstable, ... }:
let
  pkgs-unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with pkgs; [
    git

    # lsps
    nodePackages.bash-language-server
    lua-language-server

    marksman

    pyright
    python311Packages.python-lsp-server

    taplo

    nil

    pkgs-unstable.typst-lsp

    nodePackages.typescript-language-server
    vscode-langservers-extracted

    texlab
    ltex-ls

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

    # terminal pdfreader
    termpdfpy

    # Build tools
    just

    # rust stuff
    rustup

    # Misc
    graphviz
    gh

    # Java
    jdk
  ];
}
