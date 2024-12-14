# Based on https://nixos.org/wiki/Steam
{ config, pkgs, ... }:

{
  hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}
