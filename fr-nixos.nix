{
  nixpkgs,
  disko,
  home-manager,
}: {
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      disko.nixosModules.disko
      ./disks.nix

      ./nixos/gen/configuration.nix
      ./nixos/gen/hardware-configuration.nix

      home-manager.nixosModules.home-manager
      ./nixos/configuration.nix
    ];
  };
}
