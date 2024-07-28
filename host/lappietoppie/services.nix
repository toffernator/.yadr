{ ... }: {
  services = {
    xserver.videoDrivers = [ "nouveau" ];

    printing = {
      # CUPS
      enable = true;
    };

    pipewire = {
      # For sound
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    flatpak.enable = true;
  };
}
