{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI tools
    git
    zellij

    # Build tools
    just

    # rust stuff
    rustup

    # Misc
    typst
    gh
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

    casks = [
      "raycast"

      "alacritty"
      "visual-studio-code"

      "languagetool"

      "logi-options+"

      "messenger"
      "discord"
      "slack"

      "mochi"
      "obsidian"
      "rectangle"
      "zotero"

      "microsoft-edge"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "microsoft-teams"

      "google-chrome"
      "google-drive"

      "ultimaker-cura"

      "docker"

      "vlc"

      "ghidra"
      "wireshark"

      "bruno"

      "cloudflare-warp"

      "darktable"

      "virtualbox"
    ];

    masApps = {
      Xcode = 497799835;
    };
  };
}
