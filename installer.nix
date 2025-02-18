{
  lib,
  pkgs,
  modulesPath,
  ...
} @ inputs: let
  installerPath = "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix";
  baseMod = (import "${modulesPath}/profiles/base.nix") inputs;

  defaultSystemPackages = baseMod.environment.systemPackages;
  defaultSupportedFilesystems = baseMod.boot.supportedFilesystems;
in {
  imports = [installerPath];

  nixpkgs.config.allowUnfree = true;
  nix.channel.enable = false;
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [
        "https://mirrors.bfsu.edu.cn/nix-channels/store/"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store/"
        "https://mirrors.ustc.edu.cn/nix-channels/store/"
        # "https://mirror.sjtu.edu.cn/nix-channels/store/"
      ];
    };
  };

  environment.systemPackages =
    defaultSystemPackages
    ++ (with pkgs; [
      git
      fd
      gnumake
      curl
    ]);
  networking.wireless.iwd.enable = true;
  networking.wireless.enable = lib.mkForce false;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.supportedFilesystems =
    lib.mkForce (lib.lists.filter (x: x != "zfs") defaultSupportedFilesystems);
}
