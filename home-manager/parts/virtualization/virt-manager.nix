{ }:

{
  # Maybe for this to work I need to place `programs = { dconf.enable = true; };`
  # somewhere on the system level for machines that use this virt-manager?
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
