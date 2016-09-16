# Driver support, etc for Yubikeys
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    opensc pcsctools libu2f-host yubikey-personalization
  ];
  services.pcscd.enable = true;
  services.udev.packages = [
    pkgs.libu2f-host
    pkgs.yubikey-personalization
  ];
}
