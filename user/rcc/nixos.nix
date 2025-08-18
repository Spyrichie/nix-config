# Config for the user rcc (me)
{ pkgs, username, ... }:
{
  imports = [
    ../../modules/plasma6.nix
    ../../programs/vscode.nix
  ];

  users.users.${username} = {
    # Programs
    packages = with pkgs; [
      anki
      aseprite
      audacity
      #blender
      brave
      css-html-js-minify
      #davinci-resolve
      devenv
      dopamine
      dropbox
      emacs
      freecad-wayland
      godot_4
      hunspell
      inkscape-with-extensions
      keepassxc
      kicad
      krita
      #labplot
      libreoffice-qt
      netbeans
      obs-studio
      obsidian
      orca-slicer
      postman
      qbittorrent
      readest
      sparrow
      spotify
      qalculate-gtk
      thunderbird
      tor-browser
      transmission_4-qt
      vesktop
      vlc
#       (vscode-with-extensions.override {
#         vscode = vscodium;
#         vscodeExtensions = with vscode-extensions; [
#           bbenoist.nix
#           ms-python.vscode-pylance
#           ms-python.python
#           bmewburn.vscode-intelephense-client
#         ]; })
      vulkan-tools
      yed
      zap
      zoom-us

      # Games
      doomrunner
      endless-sky
      gnuchess
      kdePackages.knights
      lutris
      mangohud
      prismlauncher
      protontricks
      protonup-qt
      slipstream
      starsector
      steam-run

      # KDE packages
      kdePackages.kdeconnect-kde
      kdePackages.dolphin-plugins
      kdePackages.dolphin-plugins
      kdePackages.isoimagewriter
      kdePackages.kate
      #kdePackages.kdenlive
      kdePackages.plasma-browser-integration
    ];
  };

  programs = {
    # Install GnuPG
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
    };

    # Install Steam
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Install LibreWolf
    firefox = {
      enable = true;
      package = pkgs.librewolf;
      nativeMessagingHosts.packages = [ pkgs.kdePackages.plasma-browser-integration ];
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        Preferences = {
          "privacy.resistFingerprinting" = false;
          "privacy.fingerprintingProtection" = true;
          "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
        };
        ExtensionSettings = {
          "keepassxc-browser@keepassxc.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
            installation_mode = "force_installed";
          };
          "plasma-browser-integration@kde.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
  };

  # Set Firefox policies.json to use Librewolf's path.
  environment.etc."firefox/policies/policies.json".target = "librewolf/policies/policies.json";

  # Services
  services = {
    openssh.enable = true;
    resolved.enable = true;

    # Install MullVad
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };
}
