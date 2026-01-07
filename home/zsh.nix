{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "e0165eaa730dd0fa321a6a6de74f092fe87630b0";
          sha256 = "e2b5b637e6a79001f8b00e926b99abf482ac74083b59382b9b2a89d95d6fca04";
        };
      }
      {
        name = "forgit";
        src = pkgs.fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "00ed721ece5156aab7795ae885593f9f8582b0cc";
          sha256 = "5ded6dbf8673468572b62ce1a8a4303b2750f48d1da9e36722ef6ccc7e33038c";
        };
      }
    ];
  };
}
