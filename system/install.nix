{ config, pkgs, ... }:

{
  imports = [ <nixos/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel.nix> ];
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
}
