{ config, lib, pkgs, vars, ... }: 
let cfg = config.git; in
{
  imports = [ ];
  options = {
    git.enable = lib.mkEnableOption (lib.mdDoc "");
    git.config = lib.mkOption {
      type = lib.types.path;
      default = ./.gitconfig;
      description = lib.mdDoc "The path to the dotfiles configuring git";
    };
  };
  config = lib.mkIf (cfg.enable) {
    programs.git = {
      enable = true;
      delta = {
        enable = true;
        package = pkgs.delta;
      };

    };

    home.file = {
      ".gitconfig" = {
        enable = true;
        source = cfg.config;
        target = ".gitconfig";
      };
    };
  };
}

