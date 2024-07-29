{ config, lib, vars, ... }: 
let cfg = config.alacritty; in
{
  imports = [ ];
  options = {
    alacritty.enable = lib.mkEnableOption (lib.mdDoc "");
    alacritty.config = lib.mkOption {
      type = lib.types.path;
      default = ./config;
      description = lib.mdDoc "The path to the dotfiles configuring alacritty";
    };
  };
  config = lib.mkIf (cfg.enable) {
    programs.alacritty = { enable = true; };
    home.file = {
      "alacritty" = {
        source = cfg.config;
        target = ".config/alacritty";
        recursive = true;
      };
    };
  };
}

