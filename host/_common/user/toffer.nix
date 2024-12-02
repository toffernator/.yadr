{ pkgs, ... }: {
  users = {
    users.toffer = {
      isNormalUser = true;
      group = "toffer";
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "camera"
        "networkmanager"
        "lp"
        "scanner"
        "libvirtd"
        "docker"
      ];

      packages = with pkgs; [ home-manager ];

      shell = pkgs.zsh;
    };

    groups.toffer = { };

    defaultUserShell = pkgs.zsh;

  };

  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
    font-awesome
    corefonts # Microsoft Fonts
    nerd-fonts.jetbrains-mono
  ];

  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ zsh ];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SHELL = "${pkgs.zsh}/bin/zsh";
    };
  };
}
