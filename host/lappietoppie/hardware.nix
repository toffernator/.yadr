{ config, pkgs, ... }: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  hardware = {
    opengl = {
      # Hardware Accelerated Video
      enable = true;
      driSupport32Bit = true;
    };

    sane = {
      # Scanning
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
    };

    nvidia = {
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Use the NVidia open source kernel module (which isn't “nouveau”).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      open = false;

      modesetting.enable = true;

      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      powerManagement.enable = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      prime = {
        # Make sure to use the correct Bus ID values for your system!
        intelBusId = "PCI:0:0:2";
        nvidiaBusId = "PCI:0:3c:0";
      };
    };
  };

  # Necessary for pipewire
  hardware.pulseaudio.enable = false;
  services = {
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
