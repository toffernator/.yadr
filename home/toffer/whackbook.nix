{ pkgs, ... }: {
  imports = [
    ./_part/desktop/common

    ./_part/editor/nvim

    ./_part/cli/bat.nix
    ./_part/cli/fzf.nix
    ./_part/cli/git
    ./_part/cli/oh-my-posh.nix
    ./_part/cli/zoxide.nix
    ./_part/cli/zsh.nix
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
