{ lib, ... }: {
  security = {
    rtkit.enable = lib.mkDefault true;
    polkit.enable = lib.mkDefault true;
    sudo.wheelNeedsPassword = lib.mkDefault true;
  };
}
