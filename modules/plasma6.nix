{ pkgs, ... }:
{
  # Plasma6 related options.
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.qtwebengine

    # Fonts
    corefonts
    vista-fonts
  ];
}
