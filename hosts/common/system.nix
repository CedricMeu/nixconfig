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
    packages = with pkgs; [
      # packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.monoid
      nerd-fonts.caskaydia-cove
    ];
  };
}
