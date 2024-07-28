{ pkgs, ... }: {
  users.users.toffer = {
    name = "toffer";
    home = "/Users/toffer";
    shell = pkgs.zsh;
  };
}
