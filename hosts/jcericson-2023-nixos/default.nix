{ config, options, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/wayland.nix
    ../../system/libinput.nix
    ../../system/libvirt.nix
    ../../system/video-games.nix
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./home-assistant.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "jcericson-2023-nixos"; # Define your hostname.
    hostId = "2a5d5725";

    #interfaces.wlp2s0.useDHCP = true;
    #interfaces.enp0s20f0u4u2.useDHCP = true;
  };

  # The luk partitions isn't autodetected
  boot.initrd.luks.devices."luksroot" = {
    device = "/dev/disk/by-partuuid/86b51f08-155e-43c3-91c8-c18b63e3d983";
    preLVM = true;
    allowDiscards = true;
  };

  #virtualisation.virtualbox.host.enable = true;
  #users.groups.vboxusers.members = [ "jcericson" ];
  #virtualisation.docker.enable = true;
  #users.groups.docker.members = [ "jcericson" ];

  #networking.firewall.allowedUDPPortRanges = [
  #  { from = 6112; to = 6119; }
  #];

  programs.adb.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "20.09";

  # Unfortunately needed to get drivers
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = false;
    displayManager.xpra.enable = false;
    displayManager.sx.enable = false;
    displayManager.startx.enable = false;
  };
  services.displayManager.sddm.enable = false;
  systemd.services.display-manager.enable = false;
}
