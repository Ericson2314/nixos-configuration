{ config, pkgs, ... }:

{
  nixpkgs.config.firefox = {
    #enableGnomeExtensions = true;
    #enableGoogleTalkPlugin = true;
    #enableAdobeFlash = true;
  };

  environment.systemPackages = with pkgs; [
    # Browser
    firefox
    chromium

    signal-desktop

    # Development
    (gitFull.override { guiSupport = true; })

    # Desktop Env
    dmenu
    taffybar

    # Bits of Gnome
    # gnome3.gnome_terminal
    evince

    # Terminal emulator
    termite
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    autorun = true;

    # Enable the Light Desktop Manager
    displayManager.lightdm.enable = true;

    # Enable the KDE Desktop Environment.
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;

    # Enable the GNOME Desktop Environment.
    # displayManager.gdm.enable = true;
    # desktopManager.gnome3.enable = true;
    # desktopManager.gnome3.default = "gnome3";

    # Enable XMonad
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.xmonad.extraPackages = p: with p; [ taffybar ];
    windowManager.default = "xmonad";
    desktopManager.default = "none";
  };

  services.upower.enable = true;

  # no acidental shutdowns.
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchDocked = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
  '';

  # locks X and text vtys.
  services.physlock.enable = true;
  services.physlock.allowAnyUser = true;

  # Media Keys
  sound.mediaKeys.enable = true;
  services.actkbd.bindings = [
    { keys = [ 224 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -U 4"; }
    { keys = [ 225 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -A 4"; }
    { keys = [ 229 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight down"; }
    { keys = [ 230 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight up"; }
  ];

  services.redshift = {
    enable = true;
    # New York
    latitude = "40.7128";
    longitude = "-74.0060";
    temperature.night = 1500;
    extraOptions = [ "-m randr" ];
  };
}
