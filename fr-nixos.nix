{
  nixpkgs,
  disko,
}: {
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      disko.nixosModules.disko
      ./disks.nix

      ./gen/configuration.nix
      ./gen/hardware-configuration.nix

      ./nixos/configuration.nix
    ];
  };
}
