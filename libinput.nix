# Sane defaults if the synaptics driver is to be used
{ config, pkgs, ... }:

{
  services.xserver.libinput = {
    enable = true;

    accelSpeed = "1.0";
    accelProfile = "adaptive";

    naturalScrolling = true;

    tapping = false;
  };
}
