{ pkgs, username, nix-vscode-extensions, ... }:
{
  nixpkgs.overlays = [
    nix-vscode-extensions.overlays.default
  ];

  user.users.${username}.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with open-vsx; [
        devsense.phptools-vscode
      ];
    })
  ];
}
