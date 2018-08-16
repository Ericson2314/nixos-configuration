{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../graphical.nix
    ../synaptics.nix
    ./wireless.nix
    ./touchpad.nix
  ];

  networking.hostName = "john-2006-nixos";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "16.03";

  nix.maxJobs = 2;
}
