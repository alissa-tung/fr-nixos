{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "128M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];

                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd"];
                  };

                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd"];
                  };

                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
