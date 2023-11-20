{ config, pkgs, host, vars, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/virtualization/docker.nix
  ];

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

  hardware = {
    pulseaudio.enable = false;

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

  networking.hostName = host.hostName;

  gnome.enable = true;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  nixpkgs.config.permittedInsecurePackages = [
    # Teams became insecure, and I want to be hacked
    "teams-1.5.00.23861"
  ];

  environment = {
    systemPackages = with pkgs;
      [
        # Edge works good for teams, I can't figure out how to have multiple team
        # accounts using `teams` package
        microsoft-edge
        teams
        firefox
        ungoogled-chromium
        discord
        nodejs_20
        anki-bin
        # TODO: Move to modules/programs/rstudio.nix or to shells/stan.nix for now
        #       follow https://mc-stan.org/cmdstanr/ to get cmdstanr installed.
        rstudio

        # TODO: Move to haskell module / neovim for the LSP
        cabal-install
        ghc
        haskell-language-server
      ];
  };

  # Overlay pulls latest version of Discord
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (
        _: {
          src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
            sha256 = "0z4h5cf1zz2zrm331j1zyjnyqw89p28782j4nc8qscf55hrrsrij";

          };
        }
      );
    })
  ];

  programs.light.enable = true; # Monitor Brightness

  systemd.tmpfiles.rules = [
    # Temporary Bluetooth Fix
    "d /var/lib/bluetooth 700 root root - -"
  ];
  systemd.targets."bluetooth".after = [ "systemd-tmpfiles-setup.service" ];
}
