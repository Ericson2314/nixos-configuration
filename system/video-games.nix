# Based on https://nixos.org/wiki/Steam
{ config, pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
