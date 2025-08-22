# VSCode config.
{ pkgs, pkgs-stable, username, nix-vscode-extensions, ... }:
{
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  users.users.${username}.packages = [
    (pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium;
      vscodeExtensions = [
        pkgs.open-vsx.bbenoist.nix
        pkgs.open-vsx.editorconfig.editorconfig
        pkgs-stable.vscode-extensions.devsense.phptools-vscode
        pkgs.vscode-marketplace.ms-python.vscode-pylance
        pkgs.open-vsx.ms-python.python
      ];
    })
  ];
}
