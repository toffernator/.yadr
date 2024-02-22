{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [ ../../desktops ];

  networking.hostName = "lappietoppie";

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    # NVidia doesn't always play nice with linuxPackages_latest
    # https://discourse.nixos.org/t/nvidia-fails-to-build/34392/3
    #
    # Using longterm version from https://kernel.org/
    kernelPackages = pkgs.linuxPackages_6_1;
  };

  systemd.tmpfiles.rules = [
    # Temporary Bluetooth Fix
    "d /var/lib/bluetooth 700 root root - -"
  ];
  systemd.targets."bluetooth".after = [ "systemd-tmpfiles-setup.service" ];

  hardware = {
    opengl = {
      # Hardware Accelerated Video
      enable = true;
      driSupport = true;
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
      # Sound
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

  hyprland.enable = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  programs = { dconf.enable = true; };
}
