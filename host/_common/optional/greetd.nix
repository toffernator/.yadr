{ pkgs, lib, ... }: {
  environment = { systemPackages = with pkgs; [ greetd.tuigreet ]; };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --time --remember --cmd ${
            lib.getExe pkgs.sway
          }";
        # command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
      };
    };
  };
}
