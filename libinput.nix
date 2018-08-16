# Sane defaults if the libinput driver is to be used
{ config, pkgs, ... }:

{
  services.xserver.libinput = {
    enable = true;

    #accelSpeed = "0.0";
    accelProfile = "adaptive";

    naturalScrolling = true;

    tapping = false;
  };
}
