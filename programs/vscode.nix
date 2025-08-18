{ pkgs, username, nix-vscode-extensions, nixpkgs-stable, ... }:
{
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  users.users.${username}.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = [
        #vscode-extensions.devsense.phptools-vscode
        open-vsx.bbenoist.nix
        open-vsx.ms-python.vscode-pylance
        open-vsx.ms-python.python
      ];
    })
    blender
  ];
}
