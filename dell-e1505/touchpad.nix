{ config, pkgs, ... }:

{
  services.xserver.synaptics = {
    enable           = true;

    accelFactor      = "1";

    twoFingerScroll  = true;
    horizontalScroll = true;
  };
}
