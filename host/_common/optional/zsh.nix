{ ... }: {
  # This ensures that there is completion for system packages, even though zsh completion is configured via 
  # home-manager.
  environment.pathsToLink = [ "/share/zsh" ];
}
