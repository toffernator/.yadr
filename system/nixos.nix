# This configuration is shared across all nixos hosts.

{ inputs, outputs, vars, lib, config, pkgs, ... }:

{
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    inputs.home-manager.nixosModules.home-manager

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    # TODO: Move into individual hosts that want virtualization
    ./parts/virtualization/docker.nix
    ./parts/virtualization/virt-manager.nix
  ];

  time.timeZone = "Europe/Amsterdam";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
    supportedLocales = [ "en_US.UTF-8/UTF-8" "nl_NL.UTF-8/UTF-8" ];
  };

  users.users = {
    toffer = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "camera"
        "networkmanager"
        "lp"
        "scanner"
        "input" # for waybar
      ];
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  environment = {
    variables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages = with pkgs; [
      coreutils
      git
      wget
      zip
      unzip
      wl-clipboard
      vim

      alsa-utils
      pipewire
      wireplumber
      pulseaudio
    ];
  };

  fonts.packages = with pkgs; [
    # Fonts
    carlito # NixOS
    vegur # NixOS
    # TODO: Move to hosts/laptop/configuration.nix
    jetbrains-mono
    font-awesome
    corefonts # Microsoft Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars pkgs; };
    users = {
      # Import your home-manager configuration
      # the below "just" imports the nix expression from home.nix
      toffer = import ../home-manager/home.nix;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

}
