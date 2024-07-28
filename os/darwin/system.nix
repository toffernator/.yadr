{ ... }: {
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        QuitMenuItem = true;
        FXPreferredViewStyle = "clmv";
      };
      screencapture.location = "~/Pictures/screenshots";

      dock = {
        autohide = true;
        mru-spaces = false;
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0; # When space allows
      };

    };

    keyboard = { enableKeyMapping = true; };
  };
}
