{ pkgs, ... }: {
  imports = [
    # ./_part/cli
    # ./_part/desktop/common
    ./_part/editor/nvim
  ];

  neovim.enable = true;

  programs.zsh = { enable = true; };

  home = {
    packages = with pkgs; [
      jq
      httpie

      nixos-generators

      alacritty
    ];

    stateVersion = "23.05";
  };
}
