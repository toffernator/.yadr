{ lib, ... }: {
  i18n = { defaultLocale = lib.mkDefault "en_US.UTF-8"; };

  location.provider = "geoclue2";
  time.timeZone = lib.mkDefault "Europe/Amsterdam";
}
