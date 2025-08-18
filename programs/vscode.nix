{ pkgs, pkgs-stable, username, nix-vscode-extensions, ... }:
{
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  users.users.${username}.packages = [
    (pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium;
      vscodeExtensions = with pkgs; [
        open-vsx.bbenoist.nix
        vscode-marketplace.ms-python.vscode-pylance
        open-vsx.ms-python.python
      ];
    })
    pkgs-stable.blender
  ];
}
