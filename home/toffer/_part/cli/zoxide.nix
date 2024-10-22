{ pkgs, ... }:

let
  shellAliases = {
    cd = "z";
    cdi = "zi";
  };
in {
  home.packages = with pkgs; [ fzf ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.bash = { inherit shellAliases; };
  programs.zsh = { inherit shellAliases; };

}

