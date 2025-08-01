{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    git
    gitui
    gh
    zellij
    eza
    edir

    zulu23

    gotools

    # Misc
    mods
    typst
    carapace
    wget

    coq_8_20
    coqPackages_8_20.vscoq-language-server

    (pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
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
    ];

    casks = [
      "raycast"
      "rectangle"
      "logi-options+"

      "ghostty"
      "vscodium"
      "android-studio"

      "messenger"
      "discord"
      "slack"

      "google-chrome"
      "google-drive"

      "docker-desktop"

      "cloudflare-warp"
      "tailscale-app"

      "microsoft-teams"

      "eclipse-rcp"
      "intellij-idea-ce"
      "tableplus"
      "zed"

      "zotero"

      "minecraft"

      "affine"
      "lm-studio"

      "darktable"
      "rawtherapee"
    ];

    masApps = {
      Xcode = 497799835;
    };
  };
}
