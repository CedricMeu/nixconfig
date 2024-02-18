{ pkgs, nixpkgs-unstable, ... }:
let
  pkgs-unstable = nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  environment.systemPackages = with pkgs; [
    git

    # editors
    helix

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

    rust-analyzer

    texlab
    ltex-ls

    # formatters
    black
    dprint
    nixpkgs-fmt
    typstfmt

    # terminal pdfreader
    termpdfpy

    # Build tools
    just
  ];
}
