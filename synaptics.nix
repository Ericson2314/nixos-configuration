# Sane defaults if the synaptics driver is to be used
{ config, pkgs, ... }:

{
  services.xserver.synaptics = {
    enable = true;

    minSpeed = "0.1";
    maxSpeed = "15";
    accelFactor = "0.8";

	tapButtons = false;
	palmDetect = true;

    twoFingerScroll = true;
    vertEdgeScroll = false;
    horizontalScroll = true;

    # "Natural" scrolling
    additionalOptions = ''
      Option "VertScrollDelta" "-30"
      Option "HorizScrollDelta" "-30"
    '';
  };
}
