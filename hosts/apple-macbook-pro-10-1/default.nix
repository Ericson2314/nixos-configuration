{ config, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/x.nix
    ../../system/libinput.nix
    ../../system/yubikey.nix
    ../../../hardware-configuration.nix # Include the results of the hardware scan.
    (import ../../dep/nixos-hardware/thunk.nix + "/apple/macbook-pro/10-1")
  ];

  # For Broadcom chip
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Supposed to get PTYs back, but didn't
  #boot.blacklistedKernelModules = [ "i915" ];

  networking.hostName = "John-Galois-NixOS"; # Define your hostname.

  # Hardware config generater currently ignores mountpoints using FUSE
  fileSystems."/exchange" = {
    device = "/dev/disk/by-partlabel/exchange";
    fsType = "exfat";
  };

  # No more accidental shutdowns!
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.03";
}
