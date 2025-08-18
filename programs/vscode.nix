{ pkgs, pkgs-stable, username, nix-vscode-extensions, ... }:
{
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  users.users.${username}.packages = [
    (pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium;
      vscodeExtensions = with pkgs.open-vsx; [
        bbenoist.nix
        ms-python.vscode-pylance
        ms-python.python
      ];
    })
    pkgs-stable.blender
  ];
}
