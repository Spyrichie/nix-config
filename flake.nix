{
  description = "NixOS config";

  inputs = {
    # Default branch to use. (unstable in this case)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Stable channel.
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    # NixOS Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    # VSCode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    # Home Manager
#     home-manager = {
#       url = "github:nix-community/home-manager/release-25.05";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
    # Plasma Manager
#     plasma-manager = {
#       url = "github:nix-community/plasma-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#       inputs.home-manager.follows = "home-manager";
#     };
  };
  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, nix-vscode-extensions /*, home-manager, plasma-manager*/ }@inputs: {
    overlays = {
      pkg-sets = (
        final: prev: {
          stable = import inputs.nixpkgs-stable { system = final.system; };
        }
      );
    };
    nixosConfigurations = {
      rcc-laptop =
      let
          username = "rcc";
          specialArgs = { inherit username; inherit nix-vscode-extensions; inherit  nixpkgs-stable; };
      in
      nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";

        modules = [
          ./hosts/rcc-laptop
          ./user/${username}/nixos.nix

#           home-manager.nixosModules.home-manager
#           {
#             home-manager.useGlobalPkgs = true;
#             home-manager.useUserPkgs = true;
#             home-manager.shareModules = [ plasma-manager.homeManagerModules.plasma-manager ];
#
#             home-manager.extraSpecialArgs = inputs // specialArgs;
#             home-manager.users.${username} = import ./user/${username}/home.nix;
#           }
        ];
      };
      rcc-desktop = let
        username = "rcc";
        specialArgs = { inherit username; };
      in
      nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        system = "x86_64-linux";

        modules = [
          ./hosts/rcc-desktop
          ./user/${username}/nixos.nix
        ];
      };
    };
  };
}
