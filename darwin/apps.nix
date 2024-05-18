{ ... }:
{
  homebrew = {
    enable = true;

    global.brewfile = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    masApps = {
      Xcode = 497799835;
      Pages = 409201541;
    };

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
      # {
      #   name = "popcorn-official/popcorn-desktop";
      #   clone_target = "https://github.com/popcorn-official/popcorn-desktop.git";
      # }
    ];

    casks = [
      "raycast"

      "kitty"
      "alacritty"
      "visual-studio-code"

      "languagetool"

      "logi-options-plus"

      "messenger"
      "discord"

      "mochi"
      "obsidian"
      "rectangle"
      "zotero"

      "microsoft-edge"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "microsoft-teams"

      "ultimaker-cura"

      "docker"

      "vlc"

      "ghidra"
      "wireshark"

      "bruno"

      "cloudflare-warp"

      "darktable"

      # "popcorn-time"
    ];
  };
}
