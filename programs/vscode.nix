{ pkgs, username, nix-vscode-extensions, ... }:
{
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  users.users.${username}.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with open-vsx; [
        bbenoist.nix
        ms-python.vscode-pylance
        ms-python.python
      ];
    })
    stable.blender
  ];
}
