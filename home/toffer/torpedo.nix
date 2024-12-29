{ pkgs, ... }: {
  imports = [
    ./_part/cli/bat.nix
    ./_part/cli/distrobox.nix
    ./_part/cli/fzf.nix
    ./_part/cli/git
    ./_part/cli/oh-my-posh.nix
    ./_part/cli/zoxide.nix
    ./_part/cli/zsh.nix
    ./_part/desktop/common
    ./_part/desktop/nixos
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
