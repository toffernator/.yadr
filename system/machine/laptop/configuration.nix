{ inputs, outputs, vars, lib, config, pkgs, ... }: {

  imports = [
    ../../parts/desktops
    ../../parts/virtualization/docker.nix
    ../../parts/virtualization/virt-manager.nix
  ];

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
    # Use the longterm version from https://kernel.org/, for which you can find
    # find the corresponding package with:
    # $ nix repl
    # nix-repl> pkgs.linux_Packages_<TAB>
    kernelPackages = pkgs.linuxPackages_6_8;
  };

  systemd.tmpfiles.rules = [
    # TODO: Figure out what this does and if it still needs to be here.
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
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nouveau" ];

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

  users.users = {
    toffer = {
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "camera"
        "networkmanager"
        "lp"
        "scanner"
        "input" # for waybar
        "libvirtd" # for virt-manager
      ];
    };
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    font-awesome
    corefonts # Microsoft Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # FIXME: This is for Sway, not unique to laptop
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # TODO: What's the correct choice here? I just followed the error output to get it up and running.
    config.common.default = "*";
  };

  networking.networkmanager.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
