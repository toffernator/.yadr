{ config, lib, vars, ... }:

{
  imports = [ ];
  options = {
    wezterm.enable = lib.mkEnableOption (lib.mdDoc "");
    # alacritty.dotfiles = lib.mkOption {
    #   type = lib.types.path;
    #   default = "${vars.homeDir}/.yadr/dotfiles/alacritty";
    #   description = lib.mdDoc "The path to the dotfiles configuring alacritty";
    # };
  };
  config = lib.mkIf (config.alacritty.enable) {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

