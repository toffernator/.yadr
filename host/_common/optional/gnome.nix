{ pkgs, ... }:

{
  services = {
    libinput.enable = true;

    xserver = {
      enable = true;
      xkb = {
        options = "eurosign:e";
        layout = "us";
      };
      # Enable touchpad support (enabled default in most desktopManager).
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [ adwaita-icon-theme ];
    gnome = {
      excludePackages = with pkgs; [
        gnome-tour
        gedit
        cheese # webcam tool
        gnome-music
        gnome-terminal
        epiphany # web browser
        geary # email reader
        evince # document viewer
        gnome-characters
        totem # video player
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
      ];
    };
  };
}
