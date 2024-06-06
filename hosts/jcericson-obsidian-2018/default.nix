{ config, options, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/wayland.nix
    ../../system/libinput.nix
    ../../system/video-games.nix
    ./hardware-configuration.nix # Include the results of the hardware scan.
    (import ../../dep/nixos-hardware/thunk.nix + "/dell/xps/15-9550/nvidia")
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

  # Avoid log spam after resume. See
  # https://bugzilla.kernel.org/show_bug.cgi?id=201857 for details.
  boot.blacklistedKernelModules = [ "i2c_hid" ];

  virtualisation.virtualbox.host.enable = true;
  users.groups.vboxusers.members = [ "jcericson" ];
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

  # hardware.nvidia.powerManagement.enable = true;
  # hardware.nvidia.powerManagement.finegrained = true;

  # Unfortunately needed to get drivers
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = false;
    displayManager.sddm.enable = false;
    displayManager.xpra.enable = false;
    displayManager.sx.enable = false;
    displayManager.startx.enable = false;
  };
  systemd.services.display-manager.enable = false;
}
