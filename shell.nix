{pkgs}:
pkgs.mkShell {
  packages = with pkgs; [
    alejandra
    git
    gnumake
    nodePackages_latest.prettier
  ];
}
