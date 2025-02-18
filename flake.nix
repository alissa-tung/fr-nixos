{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    disko = {
      url = "github:nix-community/disko";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs = {nixpkgs.follows = "nixpkgs";};
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    disko,
    nixos-generators,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        formatter = pkgs.alejandra;
        devShells.default = import ./shell.nix {inherit pkgs;};

        packages.installer = nixos-generators.nixosGenerate {
          format = "raw";
          system = "x86_64-linux";
          modules = [
            ./installer.nix
          ];
        };
      }
    )
    // import ./fr-nixos.nix {
      inherit nixpkgs disko;
    };
}
