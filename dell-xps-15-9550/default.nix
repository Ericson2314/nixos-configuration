{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../hardware-configuration.nix # Include the results of the hardware scan.
  ];

  #### List swap partitions activated at boot time.
  ###swapDevices = [
  ###  { device = "/dev/disk/by-label/Swap"; }
  ###];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # For Intel Graphics to work, was default of 4.1
  boot.kernelPackages = pkgs.linuxPackages_4_4;

  networking.hostName = "John-2016-NixOS"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];

  hardware.nvidiaOptimus.disable = true;
}
