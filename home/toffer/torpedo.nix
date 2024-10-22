{ pkgs, ... }: {
  imports = [ ./_part/cli ./_part/editor/nvim ./_part/desktop/sway ];

  neovim.enable = true;

  programs.zsh = { enable = true; };

  home = {
    packages = with pkgs; [
      firefox

      jq
      httpie
      httpie-desktop
    ];

    stateVersion = "24.05";
  };
}
