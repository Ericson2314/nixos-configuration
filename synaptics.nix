# Sane defaults if the synaptics driver is to be used
{ config, pkgs, ... }:

{
  services.xserver.synaptics = {
    enable = true;

    accelFactor = "1";

	tapButtons = false;

    twoFingerScroll = true;
    vertEdgeScroll = false;
    horizontalScroll = true;
  };
}
