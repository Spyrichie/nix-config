{ pkgs, ... }:
{
  imports = [
    ../../modules/home/core.nix
    ../../modules/home/desktop/wayland/hyprland
    ../../modules/home/desktop/wayland/waybar
  ];
}
