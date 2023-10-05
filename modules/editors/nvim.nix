# Configure neovim

{ pkgs, ... }:

{
  programs = {
    neovim = {
      # For more about the options:
      # https://mipmip.github.io/home-manager-option-search/?query=programs.neovim
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };

  environment.systemPackages = [
    # For language servers and plugins
    gcc
    nodejs_20
    python311
    ripgrep
    rustc
    rustup
  ];

  system.actvivationScripts.script.text = ''
    # TODO: 
    # Use symlinks so that it only needs to run incase $CONFIG does not exist.
    # Similar to: 
    # https://github.com/MatthiasBenaets/nixos-config/blob/master/modules/editors/emacs/default.nix
    CONFIG="$HOME/.config/nvim"
    BACKUP="$HOME/.config.old/nvim"
    set -e
    
    # Make a back-up of the neovim configuration files
    mkdir -p "$BACKUP"
    cp -r "$CONFIG" "$BACKUP"

    # Copy over the configuration files
    cp -r config/nvim $CONFIG
  '';
}
