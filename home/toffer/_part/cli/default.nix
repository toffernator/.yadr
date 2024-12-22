{ ... }: {
  # FIXME: distrobox is not supported by macos and so cannot be in common
  imports = [
    ./bat.nix
    # ./distrobox.nix
    ./fzf.nix
    ./git
    ./oh-my-posh.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
