{ pkgs, username, nix-vscode-extensions, nixpkgs-stable, ... }:
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
    nixpkgs-stable.pkgs.blender
  ];
}
