{ config, lib, pkgs, ... }:

with lib; {
  imports = [ ];
  options = { media.enable = mkEnableOption (mdDoc "media"); };
  config = mkIf (config.media.enable) {
    home.packages = with pkgs; [
      ffmpeg
      vlc
      (wrapOBS {
        plugins = with obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
        ];
      })
    ];
  };
}

