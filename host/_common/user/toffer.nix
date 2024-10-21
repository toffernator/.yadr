{ pkgs, ... }: {
  users.users.toffer = {
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
}
