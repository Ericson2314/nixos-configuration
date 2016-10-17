{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../graphical.nix
    ../libinput.nix
    ../yubikey.nix
    ../../hardware-configuration.nix # Include the results of the hardware scan.
  ];

  # For Broadcom chip
  boot.kernelPackages = pkgs.linuxPackages_4_7;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.videoDrivers = [ "nvidia" "intel" ];
  hardware.opengl.driSupport32Bit = true;
  #boot.blacklistedKernelModules = [ "i915" ];

  networking.hostName = "John-Galois-NixOS"; # Define your hostname.

  # Hardware config generater currently ignores mountpoints using FUSE
  fileSystems."/exchange" = {
    device = "/dev/disk/by-partlabel/exchange";
    fsType = "exfat";
  };

  services.mbpfan.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
}
