{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../graphical.nix
    ../libinput.nix
    ../yubikey.nix
    ../../hardware-configuration.nix # Include the results of the hardware scan.
    ../../nixos-hardware/apple/macbook-pro-10-1.nix # from the nixos-hardware repo
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

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
}
