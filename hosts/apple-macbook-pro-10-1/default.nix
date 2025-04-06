{ config, pkgs, ... }:

{
  imports = [
    ../../system/common.nix
    ../../system/graphical/x.nix
    ../../system/libinput.nix
    ../../system/yubikey.nix
    ../../../hardware-configuration.nix # Include the results of the hardware scan.
    (import ../../dep/nixos-hardware/thunk.nix + "/apple/macbook-pro/10-1")
  ];

  # For Broadcom chip
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Supposed to get PTYs back, but didn't
  #boot.blacklistedKernelModules = [ "i915" ];

  networking.hostName = "John-Galois-NixOS"; # Define your hostname.

  # Hardware config generater currently ignores mountpoints using FUSE
  fileSystems."/exchange" = {
    device = "/dev/disk/by-partlabel/exchange";
    fsType = "exfat";
  };

  # No more accidental shutdowns!
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
  '';

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
  system.stateVersion = "17.03";
}
