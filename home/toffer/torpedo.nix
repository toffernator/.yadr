{ pkgs, ... }: {
  imports = [
    ./_part/cli
    ./_part/desktop/common
    ./_part/desktop/sway
    ./_part/editor/nvim
    ./_part/school
    ./_part/vms.nix
  ];

  neovim.enable = true;

  programs.zsh = { enable = true; };

  home = {
    packages = with pkgs; [
      jq
      httpie
      httpie-desktop

      nixos-generators

      alacritty
    ];

    stateVersion = "24.05";
  };
}
