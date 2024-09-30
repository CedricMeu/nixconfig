{ pkgs, ... }:
{
  programs.zsh.enable = true;

  environment.shells = [
    pkgs.zsh
    pkgs.nushell
  ];

  environment.systemPath = [
    "$HOME/.cargo/bin"
  ];

  # Fonts
  fonts = {
    packages = with pkgs;
      [
        # packages = with pkgs; [
        # icon fonts
        material-design-icons
        font-awesome

        # nerdfonts
        # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/fonts/nerdfonts/shas.nix
        (nerdfonts.override {
          fonts = [
            # symbols icon only
            "NerdFontsSymbolsOnly"
            # Characters
            "FiraCode"
            "JetBrainsMono"
            "Iosevka"
            "Monoid"
            "CascadiaCode"
          ];
        })
      ];
  };
}
