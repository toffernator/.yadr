{ lib, config, ... }:

with lib; {
  options = {
    sway = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf (config.sway.enable) {
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # TODO: What's the correct choice here? I just followed the error output to get it up and running.
      config.common.default = "*";
    };

    networking.networkmanager.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
