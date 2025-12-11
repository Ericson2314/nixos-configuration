{ config, pkgs, ... }:

{
  imports = [
    # Moved out cause it is big
    ./pubkeys.nix

    # Portable nice to haves
    ./packages.nix
  ];

  # Faster, nicer input for LUKS
  boot.initrd.systemd.enable = true;

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Enable firmware update manager service
  services.fwupd.enable = true;

  networking = {
    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # Don't set, let the "hidpi" module do this
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkb.options in tty.
  #};

  # Extra Fonts
  fonts = {
    #enableFontDir = true;
    #enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts  # Micrsoft free fonts
      inconsolata  # monospaced
      ubuntu-classic  # Ubuntu fonts
      unifont # some international languages
      source-code-pro

      source-han-sans # Adobe Source Han Sans
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # programs.ssh.startAgent = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.hplip ];
    #clientConf = ''
    #  ServerName printhost.cs.brown.edu
    #'';
  };

  # Extra shells allowed as login shells. Also helps with rysnc,
  # unison, etc over SSH
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # Users
  users.defaultUserShell = "/var/run/current-system/sw/bin/fish";
  users.mutableUsers = false;
  users.users.root = {
    #hashedPassword = null;
    hashedPassword = config.users.users.jcericson.hashedPassword;
  };
  users.users.jcericson = {
    uid = 1000;
    createHome = true;
    description = "John Cotton Ericson";
    extraGroups = [
      "jcericson"
      "networkmanager"
      "wheel"
      config.services.kubo.group
    ];
    # packages = with pkgs; [
    #   tree
    # ];
    isSystemUser = false;
    isNormalUser = true;
    useDefaultShell = true;
  };

  services.kubo = {
    #package = pkgs.kubo_latest;
    enable = true;
    settings.Addresses.API = ["/ip4/127.0.0.1/tcp/5001"];
  };
  networking.firewall.allowedTCPPorts = [ 4001 ];
  networking.firewall.allowedUDPPorts = [ 4001 ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;
}
