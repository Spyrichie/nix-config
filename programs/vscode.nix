{ pkgs, username, nix-vscode-extensions, ... }:
let
  # VSCode extensions
  nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
in
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
  ];
}
