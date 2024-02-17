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
    ];

    brews = [ ];

    casks = [
      "raycast"

      "kitty"
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
    ];
  };
}
