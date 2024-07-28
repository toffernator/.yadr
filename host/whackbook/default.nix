{ ... }: {
  networking = {
    computerName = "whackbook";
    hostName = "whackbook";
  };

  nixpkgs = { hostPlatform = "x86_64-darwin"; };

  security.pam.enableSudoTouchIdAuth = true;

  system.defaults = { screensaver.askForPasswordDelay = 10; };

}

