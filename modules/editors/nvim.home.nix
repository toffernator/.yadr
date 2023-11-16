{ config, lib, pkgs, ... }:

with lib;
{
  options = {
    nvim = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
  config = mkIf (config.nvim.enable) {
      home.file.nvim = {
          source = "./config/nvim";
          target = ".config/nvim";
          recursive = true;
      };
  };
}
