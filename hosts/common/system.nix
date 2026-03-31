{ pkgs, ... }:
{
  environment.systemPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];

  # Fonts
  fonts = {
    packages = with pkgs; [
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
