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
