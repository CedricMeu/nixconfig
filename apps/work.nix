{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    edir
    ripgrep

    # VCSs
    git
    sapling
    jujutsu

    # Misc
    comma
    wget
    jj-starship

    # Some google stuff
    (pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])

    # A java runtime
    zulu
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

      "vscodium"
      "android-studio"

      "slack"

      "google-chrome"
      "firefox"

      "docker-desktop"

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
