# This is a generated file.  Do not modify!
# Make changes to /etc/nixos/configuration.nix instead.
{ config, pkgs, ... }:

{
  services.xserver.synaptics = {
    enable           = true;

    accelFactor      = "1";

    twoFingerScroll  = true;
    horizontalScroll = true;
  };
}
