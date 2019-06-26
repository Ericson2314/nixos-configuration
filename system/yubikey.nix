# Driver support, etc for Yubikeys
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    opensc pcsctools libu2f-host yubikey-personalization
    (openvpn.override { pkcs11Support = true; })
  ];
  services.pcscd.enable = true;
  services.udev.packages = [
    pkgs.libu2f-host
    pkgs.yubikey-personalization
  ];
}
