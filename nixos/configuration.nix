{
  pkgs,
  lib,
  ...
}: {
  users.users.fr = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-material-color
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
    ];
    fcitx5.plasma6Support = true;
  };

  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    kitty
    elan
    git
    gnumake
    nil
    nodePackages_latest.nodejs
    curl
    fd
    ripgrep
    bottom
    clang-tools
    nix-output-monitor
    nix-inspect
    wechat-uos
    qq
  ];

  programs.zsh = {
    enable = true;
    promptInit = lib.mkForce "";
    interactiveShellInit =
      ''
        source "${pkgs.grml-zsh-config}/etc/zsh/zshrc"
        source "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      ''
      + builtins.readFile ../cfg/zshrc;
  };

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

      trusted-users = [
        "root"
        "fr"
      ];
    };
  };
}
