{ }: {
  users.users = {
    toffer = {
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "camera"
        "networkmanager"
        "lp"
        "scanner"
        "libvirtd" # for virt-manager
      ];
    };
  };

}
