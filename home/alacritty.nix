{ pkgs, ... }:
let
  themes = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "94e1dc0b9511969a426208fbba24bd7448493785";
    sha256 = "sha256-bPup3AKFGVuUC8CzVhWJPKphHdx0GAc62GxWsUWQ7Xk=";
  };
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      import = [
        "${themes}/themes/catppuccin_latte.toml"
      ];

      shell = {
        program = "${pkgs.zellij.outPath}/bin/zellij";
        args = [ "-l" "welcome" ];
      };

      window = {
        option_as_alt = "OnlyLeft";
      };

      font = {
        size = 12;
        normal = {
          family = "JetBrainsMono Nerd Font Mono";
          style = "Regular";
        };
      };
    };
  };
}
