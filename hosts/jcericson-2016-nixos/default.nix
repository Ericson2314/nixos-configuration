{ config, options, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/x.nix
    ../../system/libinput.nix
    ../../system/steam.nix
    ../../../hardware-configuration.nix # Include the results of the hardware scan.
    <nixos-hardware/dell/xps/15-9550> # from the nixos-hardware repo
  ];

  networking.hostName = "jcericson-2016-nixos"; # Define your hostname.

  networking.hostId = "a22fc14c";

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];

  hardware.nvidiaOptimus.disable = true;

  nix.maxJobs = 2;
  nix.buildCores = 8;

  services.xserver.videoDrivers = [
      "displaylink"
    ] ++ options.services.xserver.videoDrivers.default;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "16.03";
}
