{ pkgs, ... }:
let
  wezterm_config = builtins.readFile ./wezterm.lua;
in
{
  programs.wezterm = {
    enable = true;

    extraConfig = builtins.replaceStrings [ "ZELLIJ_PATH" ] [ "${pkgs.zellij.outPath}/bin/zellij" ] wezterm_config;
  };
}
