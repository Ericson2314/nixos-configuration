# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./passwd.nix
    ../../system/common.nix
    ../../system/graphical/x.nix
    ../../system/graphical/nvidia-offload.nix
    ../../system/libinput.nix
    ../../system/video-games.nix
    ./hardware-configuration.nix # Include the results of the hardware scan.
    <nixos-hardware/dell/xps/15-9500> # from the nixos-hardware repo
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Open the encrypted partition so the filesystems inside can be mounted.
  boot.initrd.luks.devices = {
    "carabao-luksroot" = {
      device = "/dev/disk/by-partuuid/de841346-8bf0-4229-aa48-3a3f3d77199b";
      # We don't use LVM (Linux Volume Manager) and so shouldn't wait for it.
      preLVM = true;
      # This is good for SSD performance.
      allowDiscards = true;
    };
  };

  networking = {
    hostName = "carabao"; # Define your hostname.
    hostId = "a22d83ab"; # For ZFS
  };

  hardware.nvidia.prime = {
    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
