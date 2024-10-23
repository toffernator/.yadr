{ pkgs, ... }: {
  imports =
    [ ./_part/cli ./_part/desktop/sway ./_part/editor/nvim ./_part/school ];

  neovim.enable = true;

  programs.zsh = { enable = true; };

  home = {
    packages = with pkgs; [
      jq
      httpie
      httpie-desktop

      alacritty
    ];

    stateVersion = "24.05";
  };
}
