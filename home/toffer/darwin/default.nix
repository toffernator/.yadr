{ lib, ... }: {
  imports = [ ./packages.nix ./programs.nix ];

  home = {
    username = "toffer";

    # TODO: Why is this necessay to do?
    # Either way if this module is imported then this has to be the home.
    homeDirectory = lib.mkForce "/Users/toffer";
  };
}
