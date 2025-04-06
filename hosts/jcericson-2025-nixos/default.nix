{ config, options, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/wayland.nix
    ../../system/libinput.nix
    ../../system/video-games.nix
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "jcericson-2025-nixos"; # Define your hostname.

    hostId = "a22fc14c";
  };

  # The luk partitions isn't autodetected
  boot.initrd.luks.devices."luksroot" = {
    device = "/dev/disk/by-uuid/ae41d6e7-5a97-4c3e-9f63-71f297bdc0fe";
    preLVM = true;
    allowDiscards = true;
  };

  nix.settings.max-jobs = 3;
  nix.settings.build-cores = 7;

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
  system.stateVersion = "16.03";
}
