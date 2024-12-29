{
  imports = [ ../_common/user/toffer/macos.nix ../_common/global/nixpkgs.nix ];

  networking = {
    computerName = "whackbook";
    hostName = "whackbook";
  };

  nixpkgs = { hostPlatform = "x86_64-darwin"; };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = { screensaver.askForPasswordDelay = 10; };

  system.stateVersion = 5;
}
