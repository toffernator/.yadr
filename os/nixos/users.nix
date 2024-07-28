{ pkgs, ... }: {
  users = {
    users = { toffer = { isNormalUser = true; }; };
    defaultUserShell = pkgs.zsh;
  };
}
