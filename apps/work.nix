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

    # Misc
    comma
    wget

    # coq_8_20
    # coqPackages_8_20.vscoq-language-server
    delve

    (pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])

    sapling
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
      "logi-options+"

      "ghostty"
      "vscodium"
      "android-studio"

      "messenger"
      "slack"

      "google-chrome"
      "firefox"

      "docker-desktop"

      # "cloudflare-warp"
      "tailscale-app"

      "microsoft-teams"
      "microsoft-powerpoint"

      "intellij-idea-ce"
      "tableplus"
      "zed"

      "zotero"
      "affine"

      "minecraft"

      "aerospace"

      "affinity"

      "lm-studio"
    ];

    masApps = {
      Xcode = 497799835;
    };
  };
}
