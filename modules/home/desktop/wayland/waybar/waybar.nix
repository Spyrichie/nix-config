{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";

      # Define the layout of the modules
      modules-left = [
        "custom/appmenu"
        "wlr/taskbar"
      ];

      modules-center = [
        "hyprland/workspaces"
        "clock"
      ];

      modules-right = [
        "cpu"
        "user"
        "network"
      ];

      # Define the items in the modules.
      "custom/appmenu" = {
        format = "Menu";
        exec = pkgs.writeShellScript "run-wofi" ''
          wofi --show drun
        '';
      };


    }];
  };
}
