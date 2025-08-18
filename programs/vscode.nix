{ pkgs, username, nix-vscode-extensions, nixpkgs-stable, ... }:
{
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  users.users.${username}.packages = [
    (pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium;
      vscodeExtensions = with open-vsx; [
        #vscode-extensions.devsense.phptools-vscode
        bbenoist.nix
        ms-python.vscode-pylance
        ms-python.python
      ];
    })
    nixpkgs-stable.blender
  ];
}
