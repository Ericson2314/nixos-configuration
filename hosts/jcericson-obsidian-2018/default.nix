{ config, options, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/x.nix
    ../../system/libinput.nix
    ../../system/video-games.nix
    ./hardware-configuration.nix # Include the results of the hardware scan.
    <nixos-hardware/dell/xps/15-9550/nvidia> # from the nixos-hardware repo
  ];

  networking = {
    hostName = "jcericson-obsidian-2018"; # Define your hostname.
    hostId = "2a5d5725";

    #interfaces.wlp2s0.useDHCP = true;
    #interfaces.enp0s20f0u4u2.useDHCP = true;
  };

  # The luk partitions isn't autodetected
  boot.initrd.luks.devices."luksroot" = {
    device = "/dev/disk/by-partuuid/13608ae1-f65b-449b-8e6e-67e2dc7b2ffd";
    preLVM = true;
    allowDiscards = true;
  };

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];

  #virtualisation.virtualbox.host.enable = true;
  ##virtualisation.docker.enable = true;
  #users.groups.docker.members = [ "jcericson" ];

  #networking.firewall.allowedUDPPortRanges = [
  #  { from = 6112; to = 6119; }
  #];

  programs.adb.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09";
}
