# The home manager configuration specific to my macbook
{ inputs, outputs, vars, lib, config, pkgs, ... }: {
  imports = [
    ../../parts/programs/alacritty.nix
    ../../parts/editors/nvim.nix
    ../../parts/utilities/git.nix
  ];

  config = lib.mkIf (vars.machine == "macbook") {
    home = {
      username = "toffer";
      homeDirectory = "/Users/toffer";

      packages = with pkgs; [ dotnet-sdk_8 ];
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
    };
    alacritty.dotfiles = "/Users/toffer/.yadr/dotfiles/alacritty";
    neovim.dotfiles = "/Users/toffer/.yadr/dotfiles/nvim";
    git.dotfiles = "/Users/toffer/.yadr/dotfiles/.gitconfig";
  };
}
