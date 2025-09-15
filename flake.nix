{
  description = "NixOS config";

  inputs = {
    # Default nixpkgs branch to use (unstable in this case).
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Stable channel.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # NixOS Hardware for my laptop.
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    # VSCode extensions to grab VSCode extensions that aren't packaged in nix.
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Plasma Manager
#     plasma-manager = {
#       url = "github:nix-community/plasma-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#       inputs.home-manager.follows = "home-manager";
#     };
  };
  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, nix-vscode-extensions, home-manager,/* plasma-manager*/ }@inputs: {
    nixosConfigurations =
    {
      # Laptop config.
      rcc-laptop =
      let
        username = "rcc";
        system = "x86_64-linux";
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        # Values to be passed to modules.
        specialArgs = {
          inherit username;
          inherit nix-vscode-extensions;

          # Stable nixpkgs channel.
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
        };

        modules = [
          ./hosts/rcc-laptop
          ./user/${username}/nixos.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPkgs = true;
            # home-manager.shareModules = [ plasma-manager.homeManagerModules.plasma-manager ];

            home-manager.extraSpecialArgs = inputs // specialArgs;
            home-manager.users.${username} = import ./user/${username}/home.nix;
          }
        ];
      };
    };
  };
}
