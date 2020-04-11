{ config, options, pkgs, ... }:

{
  imports = [
    ../system/common.nix
    ../system/graphical.nix
    ../system/libinput.nix
    ../../hardware-configuration.nix # Include the results of the hardware scan.
    <nixos-hardware/dell/xps/15-9550> # from the nixos-hardware repo
  ];

  # For Intel Graphics to work, 4.1 is too low, and 4.4 is sufficient
  boot.kernelPackages = pkgs.linuxPackages_4_19;

  networking.hostName = "jcericson-obsidian-2018"; # Define your hostname.
  networking.hostId = "2a5d5725";

  environment.systemPackages = with pkgs; [
    fbterm # compensate for UHD
  ];

  #hardware.nvidiaOptimus.disable = true;

  virtualisation.virtualbox.host.enable = true;
  #virtualisation.docker.enable = true;
  users.groups.docker.members = [ "jcericson" ];

  services.xserver.videoDrivers = [
      "intel"
      #"displaylink"
    ]; #++ options.services.xserver.videoDrivers.default;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

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
