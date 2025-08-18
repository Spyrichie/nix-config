{
  autoPatchelfHook,
  callPackage,
  config,
  fetchurl,
  jdk,
  jq,
  lib,
  llvmPackages,
  moreutils,
  protobuf,
  python3Packages,
  stdenv,
  vscode-utils,
  zlib,
}:

let
  inherit (vscode-utils) buildVscodeMarketplaceExtension;

  baseExtensions =
    self:
    lib.mapAttrs (_n: lib.recurseIntoAttrs) {
      devsense.phptools-vscode = buildVscodeMarketplaceExtension {
        mktplcRef =
          let
            sources = {
              "x86_64-linux" = {
                arch = "linux-x64";
                hash = "sha256-8i5nRlzd+LnpEh9trWECxfiC1W4S0ekBab5vo18OlsA=";
              };
              "x86_64-darwin" = {
                arch = "darwin-x64";
                sha256 = "14crw56277rdwhigabb3nsndkfcs3yzzf7gw85jvryxviq32chgy";
              };
              "aarch64-linux" = {
                arch = "linux-arm64";
                sha256 = "1j1xlvbg3nrfmdd9zm6kywwicdwdkrq0si86lcndaii8m7sj5pfp";
              };
              "aarch64-darwin" = {
                arch = "darwin-arm64";
                sha256 = "0nlks6iqxkx1xlicsa8lrb1319rgznlxkv2gg7wkwgzph97ik8bi";
              };
            };
          in
          {
            name = "phptools-vscode";
            publisher = "devsense";
            version = "1.41.14332";
          }
          // sources.${stdenv.system};

        nativeBuildInputs = [ autoPatchelfHook ];

        buildInputs = [
          zlib
          (lib.getLib stdenv.cc.cc)
        ];

        postInstall = ''
          chmod +x $out/share/vscode/extensions/devsense.phptools-vscode/out/server/devsense.php.ls
        '';

        meta = {
          changelog = "https://marketplace.visualstudio.com/items/DEVSENSE.phptools-vscode/changelog";
          description = "Visual studio code extension for full development integration for the PHP language";
          downloadPage = "https://marketplace.visualstudio.com/items?itemName=DEVSENSE.phptools-vscode";
          homepage = "https://github.com/DEVSENSE/phptools-docs";
          license = lib.licenses.unfree;
          maintainers = [ lib.maintainers.drupol ];
          platforms = [
            "x86_64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
            "aarch64-linux"
          ];
        };
      };
    };
  aliases = super: { };

  # TODO: add overrides overlay, so that we can have a generated.nix
  # then apply extension specific modifcations to packages.

  # overlays will be applied left to right, overrides should come after aliases.
  overlays = lib.optionals config.allowAliases [
    (self: super: lib.recursiveUpdate super (aliases super))
  ];

  toFix = lib.foldl' (lib.flip lib.extends) baseExtensions overlays;
in
lib.fix toFix
