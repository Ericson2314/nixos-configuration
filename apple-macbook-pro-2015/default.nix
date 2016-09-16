{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../libinput.nix
    ../yubikey.nix
    ../../hardware-configuration.nix # Include the results of the hardware scan.
  ];

  # For Broadcom chip
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.videoDrivers = [ "nvidia" "intel" ];
  hardware.opengl.driSupport32Bit = true;
  #boot.blacklistedKernelModules = [ "i915" ];

  networking.hostName = "John-Galois-NixOS"; # Define your hostname.

  # Hardware config generater currently ignores mountpoints using FUSE
  fileSystems."/exchange" = {
    device = "/dev/sda5";
    fsType = "exfat";
  };


}
