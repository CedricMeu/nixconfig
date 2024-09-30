{ pkgs, nurpkgs, ... }:
let
  nur = import nurpkgs { inherit pkgs; };
in
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    git
    gitui
    zellij
    go
    nodejs
    corepack
    nur.arcanist

    #java stuff
    jdk17

    # Misc
    mods
  ];

  homebrew = {
    enable = true;

    global.brewfile = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
    ];

    brews = [
      "ideviceinstaller"
      "fastlane"
      "docker"
    ];

    casks = [
      "raycast"
      "rectangle"
      "logi-options+"

      "alacritty"
      "visual-studio-code"
      "android-studio"

      "messenger"
      "discord"
      "slack"

      "google-chrome"
      "google-drive"

      "docker"

      "cloudflare-warp"
      "tailscale"

      "microsoft-teams"
    ];

    masApps = {
      Xcode = 497799835;
    };
  };
}
