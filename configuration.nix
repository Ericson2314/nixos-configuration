{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Manual per-machine config
    ./dell-e1505

    # Not tracked, so doesn't need to go in per-machine subdir
    ./passwd.nix

    # Portable nice to haves
    ./packages.nix
  ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "John-Laptop-Nix"; # Define your hostname.
    # wireless.enable = true;     # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Enable NetworkManager
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.hplip ];
    #clientConf = ''
    #  ServerName printhost.cs.brown.edu
    #'';
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    autorun = true;
  };

  # Enable the Light Desktop Manager
  services.xserver.displayManager.lightdm.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;
  # services.xserver.desktopManager.gnome3.default = "gnome3";

  # Enable XMonad
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.desktopManager.default = "none";

  security.initialRootPassword = "!";

  # Helps with rysnc, unison, etc over SSH
  programs.zsh.enable = true;

  # Users
  users.defaultUserShell = "/var/run/current-system/sw/bin/zsh";
  users.mutableUsers = false;
  users.extraUsers.john = {
    uid = 1000;
    createHome = true;
    home = "/home/john";
    description = "John Cotton Ericson";
    extraGroups = [ "john" "networkmanager" "wheel" ];
    isSystemUser = false;
    isNormalUser = true;
    useDefaultShell = true;
  };

}
