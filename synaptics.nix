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

    additionalOptions = ''
      # "Natural" scrolling
      Option "VertScrollDelta" "-30"
      Option "HorizScrollDelta" "-30"

      Option "EmulateMidButtonTime" "100"
    '';
  };
}
