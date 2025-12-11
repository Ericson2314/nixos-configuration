{ config, pkgs, ... }:

{
  nixpkgs.config.firefox = {
    #enableGnomeExtensions = true;
    #enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };

  security.rtkit.enable = true; # for pipewire

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  programs.dconf.enable = true;

  services.hardware.bolt.enable = true;

  services.upower.enable = true;

  # No acidental shutdowns.

  # These are now the default
  # services.logind.lidSwitch = "suspend";
  # services.logind.lidSwitchDocked = "ignore";
  # services.logind.lidSwitchExternalPower = "suspend";

  services.logind.settings.Login.HandlePowerKey = "suspend";

  # locks X and text vtys.
  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;

  # Media Keys
  services.actkbd.bindings = [
    { keys = [ 224 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -U 4"; }
    { keys = [ 225 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -A 4"; }
    { keys = [ 229 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight down"; }
    { keys = [ 230 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight up"; }
  ];
}
