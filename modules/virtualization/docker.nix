# Configure docker and docker-compose
# See more: https://nixos.wiki/wiki/Docker

{ config, pkgs, vars, ... }:
{
  virtualisation.docker.enable = true;
  # group membership might require reboot to take effect...
  users.groups.docker.members = [ "${vars.user}" ];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
  ];
}
