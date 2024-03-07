# The home manager configuration specific to my macbook
{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./parts/programs/alacritty.nix
    ./parts/editors/nvim.nix
    ./parts/utilities/git.nix
  ];
  home = {
    username = "toffer";
    homeDirectory = "/Users/toffer";

    packages = with pkgs; [ dotnet-sdk_8 ];
  };

  alacritty.dotfiles = "Users/toffer/.yadr/dotfiles/alacritty";
  nvim.dotfiles = "Users/toffer/.yadr/dotfiles/nvim";
  git.dotfiles = "Useres/toffer/.yadr/dotfiles/.gitconfig";
}
