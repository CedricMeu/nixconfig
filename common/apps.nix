{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    git
    zellij

    # Build tools
    just

    # rust stuff
    rustup

    # Misc
    typst
    graphviz
    gh

    # Java
    jdk
  ];
}
