{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { git.enable = mkEnableOption (mdDoc ""); };
  config = mkIf (config.git.enable) {
    programs.git = {
      enable = true;
      aliases = {
        ignore =
          "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
        a = "add";
        s = "status";
        st = "status";
        ci = "commit";
        b = "branch";
        co = "checkout";
        re = "remote";
        d = "diff";
        dc = "diff --cached";
        lol = "log --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit";
        ls = "ls-files";
        lg =
          "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        lgi =
          "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
    };
  };
}

