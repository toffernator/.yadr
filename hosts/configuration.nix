{ config, lib, pkgs, inputs, vars, ... }:

{
  imports = (
    import ../modules/desktops ++
    import ../modules/editors
  );

  users.users.${vars.user} = {
    # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" ];
  };

  time.timeZone = "Europe/Amsterdam";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # TODO: I think gcc complains with some undefined locales?
    # extraLocaleSettings = {
    # LC_ADDRESS = "en_UK.UTF-8";
    # LC_IDENTIFICATION = "en_UK.UTF-8";
    # LC_MEASUREMENT = "en_UK.UTF-8";
    # LC_MONETARY = "nl_NL.UTF-8";
    # LC_NAME = "en_UK.UTF-8";
    # LC_NUMERIC = "en_UK.UTF-8";
    # LC_PAPER = "en_UK.UTF-8";
    # LC_TELEPHONE = "en_UK.UTF-8";
    # LC_TIME = "en_UK.UTF-8";
    # };
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

  fonts.fonts = with pkgs; [
    # Fonts
    carlito # NixOS
    vegur # NixOS
    jetbrains-mono
    font-awesome
    corefonts # Microsoft Fonts
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };

    systemPackages = with pkgs; [
      alacritty
      tmux

      # CLIs
      coreutils
      git
      jq
      stow
      tldr
      unzip
      usbutils
      wget
      zip

      # Video & Audio
      alsa-utils
      pipewire
      pulseaudio
      vlc

      # Productivity
      vim

      # TODO: Move to modules/editors/nvim.nix
      neovim
      # For language servers and neovim plugin
      gcc
      nodejs_20
      python312
      ripgrep
      rustc
      rustup
      rust-analyzer
      nodePackages_latest.typescript-language-server
      nodePackages_latest.vscode-langservers-extracted
      nodePackages."@tailwindcss/language-server"
      lua-language-server
      fd
    ];

    shellAliases = {
      todo = "$EDITOR \"$HOME\"/.todo";
    };
  };

  programs = {
    dconf.enable = true;
  };

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
    openssh.enable = true;
  };

  nix = {
    # Nix Package Manager Settings
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      # Garbage Collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable; # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  
  nixpkgs.config.allowUnfree = true;

  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system# Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.05"; # Did you read the comment?
  };
}
