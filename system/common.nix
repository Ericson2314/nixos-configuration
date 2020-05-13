{ config, pkgs, ... }:

{
  imports = [
    # Moved out cause it is big
    ./pubkeys.nix

    # Not tracked, so doesn't need to go in per-machine subdir
    ../../passwd.nix

    # Portable nice to haves
    ./packages.nix
  ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  networking = {
    # wireless.enable = true;     # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Enable NetworkManager
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.vboxnet0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Extra Fonts
  fonts = {
    #enableFontDir = true;
    #enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts  # Micrsoft free fonts
      inconsolata  # monospaced
      ubuntu_font_family  # Ubuntu fonts
      unifont # some international languages
      source-code-pro

      # Adobe Source Han Sans
      sourceHanSansPackages.korean
      sourceHanSansPackages.japanese
      sourceHanSansPackages."traditional-chinese"
      sourceHanSansPackages."simplified-chinese"
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
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

  security.initialRootPassword = "!";

  # Extra shells allowed as login shells. Also helps with rysnc,
  # unison, etc over SSH
  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.ssh.startAgent = true;

  # Users
  users.defaultUserShell = "/var/run/current-system/sw/bin/fish";
  users.mutableUsers = false;
  users.users.jcericson = {
    uid = 1000;
    createHome = true;
    description = "John Cotton Ericson";
    extraGroups = [ "jcericson" "networkmanager" "wheel" ];
    isSystemUser = false;
    isNormalUser = true;
    useDefaultShell = true;
  };

  services.ipfs = {
    enable = true;
  };
}
