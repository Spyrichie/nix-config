# Config for the user rcc (me)
{ pkgs, username, ... }:
{
  imports = [
    ../../modules/plasma6.nix
  ];

  users.users.${username} = {
    # Programs
    packages = with pkgs; [
      brave
      kdePackages.dolphin-plugins
      kdePackages.kate
    ];
  };
}
