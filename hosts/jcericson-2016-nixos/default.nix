{ config, options, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/wayland.nix
    ../../system/libinput.nix
    ../../system/video-games.nix
    ./hardware-configuration.nix # Include the results of the hardware scan.
    <nixos-hardware/dell/xps/15-9550/nvidia> # from the nixos-hardware repo
  ];

  networking = {
    hostName = "jcericson-2016-nixos"; # Define your hostname.

    hostId = "a22fc14c";
  };

  # The luk partitions isn't autodetected
  boot.initrd.luks.devices."luksroot" = {
    device = "/dev/disk/by-uuid/ae41d6e7-5a97-4c3e-9f63-71f297bdc0fe";
    preLVM = true;
    allowDiscards = true;
  };

  nix.settings.max-jobs = 2;
  nix.settings.build-cores = 8;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "16.03";
}
