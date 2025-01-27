{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    git
    gitui
    gh
    zellij

    #java stuff
    jdk17

    # Misc
    mods
    typst
    carapace

    vscoqls
    coq

    (pkgs.google-cloud-sdk.withExtraComponents [ pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin ])
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

      "wezterm"
      "ghostty"
      "vscodium"
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

      "eclipse-rcp"
      "intellij-idea-ce"
      "tableplus"

      "zotero"
      # "darktable"
      # "rawtherapee"
      "minecraft"

      "siyuan"

      "lm-studio"
    ];

    masApps = {
      Xcode = 497799835;
    };
  };
}
