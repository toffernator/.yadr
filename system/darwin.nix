# System-level configuration shared across all darwin systems.
{ }:

{

  # Because of programs.zsh.enableCompletion in ../home-manager/macbook.nix
  environment.pathsToLink = [ "/share/zsh" ];

  nix.gc.interval = {
    Hour = 9;
    Minute = 0;
  };

  homebrew.casks.enable = true;
}
