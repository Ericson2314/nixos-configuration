# Sane defaults if the synaptics driver is to be used
{ config, pkgs, ... }:

{
  services.xserver.synaptics = {
    enable = true;

    minSpeed = "0.1";
    maxSpeed = "1.5";
    accelFactor = "0.8";

	tapButtons = false;

    twoFingerScroll = true;
    vertEdgeScroll = false;
    horizontalScroll = true;
  };
}
