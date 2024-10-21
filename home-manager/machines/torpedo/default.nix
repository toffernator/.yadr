{ inputs, outputs, vars, lib, config, pkgs, ... }:

{
  imports = [ ../../parts/desktops ];

  config = lib.mkIf (vars.machine == "torpedo") {
    sway.enable = true;

    home.packages = with pkgs; [ firefox ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";
  };

}
