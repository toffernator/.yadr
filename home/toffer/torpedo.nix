{ pkgs, ... }: {
  imports = [
    _part/cli/git
    _part/cli/bat.nix
    _part/cli/zoxide.nix

    _part/editor/nvim

    _part/desktop/sway
  ];

  neovim.enable = true;

  home = {
    packages = with pkgs; [ firefox ];
    stateVersion = "24.05";
  };
}
