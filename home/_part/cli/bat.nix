{ pkgs, ... }: {
  home.packages = with pkgs; [ delta fzf ];

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [ batdiff batman batgrep ];
    config = { theme = "base16"; };
  };

  programs.bash = {
    shellAliases = {
      cat = "bat";
      diff = "batdiff --delta";
      man = "batman";
      grep = "batgrep";
    };
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
      diff = "batdiff --delta";
      man = "batman";
      grep = "batgrep";
    };
  };
}

