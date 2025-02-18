{pkgs, ...}:
pkgs.vscode-with-extensions.override {
  vscodeExtensions = with pkgs.vscode-extensions;
    [
      jnoortheen.nix-ide
    ]
    ++ map (
      extension:
        pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            inherit
              (extension)
              name
              publisher
              version
              sha256
              ;
          };
        }
    )
    (import ../gen/vsc.nix).extensions;
}
