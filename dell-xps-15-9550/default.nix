{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../synaptics.nix
    ../hardware-configuration.nix # Include the results of the hardware scan.
    ../steam.nix
  ];

  #### List swap partitions activated at boot time.
  ###swapDevices = [
  ###  { device = "/dev/disk/by-label/Swap"; }
  ###];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # For Intel Graphics to work, 4.1 is too low, and 4.4 is sufficient
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "John-2016-NixOS"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];

  hardware.nvidiaOptimus.disable = true;
}
