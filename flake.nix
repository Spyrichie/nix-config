{
    description = "My system config flake.";

    inputs = {
        # Default branch to use. (unstable in this case)
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        # Stable channel.
        #nixpkgs/*-stable*/.url = "github:nixos/nixpkgs/nixos-25.05";
        # NixOS Hardware
        nixos-hardware.url = "github:nixos/nixos-hardware/master";
    };
    outputs = { self, nixpkgs, nixos-hardware }@inputs: {
        nixosConfigurations.rcc-laptop = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                ./hardware-config.nix
                ./hardware-configuration.nix
                ./graphics-config.nix
                ./network-config.nix
                ./configuration.nix
                ./user-rcc-config.nix
                nixos-hardware.nixosModules.lenovo-ideapad-15ach6
            ];
        };
    };
}
