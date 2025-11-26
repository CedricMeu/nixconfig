{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    git
    gh
    zellij
    eza
    edir

    zulu
    protobuf

    # Misc
    comma
    carapace
    wget

    # coq_8_20
    # coqPackages_8_20.vscoq-language-server
    delve

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
      "nikitabobko/tap"
    ];

    brews = [
      "ideviceinstaller"
      "fastlane"
    ];

    casks = [
      # "raycast"
      "logi-options+"

      "ghostty"
      "vscodium"
      "android-studio"

      "messenger"
      # "discord"
      "slack"

      "google-chrome"
      "google-drive"

      "docker-desktop"

      # "cloudflare-warp"
      "tailscale-app"

      "microsoft-teams"
      "microsoft-powerpoint"

      "intellij-idea-ce"
      "tableplus"
      "zed"

      "zotero"

      "minecraft"

      "affine"
      # "lm-studio"

      # "darktable"
      # "rawtherapee"

      "aerospace"
      "affinity"
    ];

    masApps = {
      Xcode = 497799835;
    };
  };
}
