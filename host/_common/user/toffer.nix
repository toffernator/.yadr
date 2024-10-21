{ pkgs, ... }: {
  users.users.toffer = {
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
  };

  fonts.packages = with pkgs; [
    carlito # NixOS
    vegur # NixOS
    font-awesome
    corefonts # Microsoft Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
