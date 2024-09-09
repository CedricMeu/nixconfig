{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    git
    zellij

    # Build tools
    just

    # Misc
    typst
    mods
  ];

  homebrew = {
    enable = true;

    global.brewfile = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    # masApps = {
    #   Xcode = 497799835;
    # };

    taps = [
      "homebrew/services"
    ];

    casks = [
      "raycast"

      "alacritty"
      "visual-studio-code"

      "languagetool"

      "logi-options-plus"

      "messenger"
      "discord"
      "slack"

      "rectangle"

      "google-chrome"
      "google-drive"

      "docker"

      "cloudflare-warp"
      "tailscale"
    ];
  };
}
