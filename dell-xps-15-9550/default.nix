{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../libinput.nix
    ../../hardware-configuration.nix # Include the results of the hardware scan.
    ../steam.nix
    ../../nixos-hardware/dell/xps-15-9550.nix # from the nixo-hardware repo
  ];

  # For Intel Graphics to work, 4.1 is too low, and 4.4 is sufficient
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "John-2016-NixOS"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];

  hardware.nvidiaOptimus.disable = true;
}
