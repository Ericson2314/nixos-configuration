# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/hardware/network/broadcom-43xx.nix>
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    #device = "/dev/disk/by-uuid/e0927b84-e935-4d66-bc0d-8893babb3db1";
    #fsType = "btrfs";
    device = "rpool/root";
    fsType = "zfs";
    #options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/nix" = {
    device = "rpool/nix";
    fsType = "zfs";
    #options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/home" = {
    device = "rpool/home";
    fsType = "zfs";
    #options = [ "noatime" "nodiratime" "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DE1F-4474";
    fsType = "vfat";
  };

  swapDevices = [
  #  { device = "/dev/disk/by-uuid/5af10c3c-044e-4cc5-b1e6-2a3f36f0ad4e"; }
  ];

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
