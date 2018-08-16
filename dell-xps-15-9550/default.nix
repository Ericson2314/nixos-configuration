{ config, options, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../graphical.nix
    ../libinput.nix
    ../../hardware-configuration.nix # Include the results of the hardware scan.
    ../steam.nix
    <nixos-hardware/dell/xps/15-9550> # from the nixos-hardware repo
  ];

  # For Intel Graphics to work, 4.1 is too low, and 4.4 is sufficient
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "John-2016-NixOS"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];

  hardware.nvidiaOptimus.disable = true;

  services.xserver.videoDrivers = [
      "displaylink"
    ] ++ options.services.xserver.videoDrivers.default;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "16.03";
}
