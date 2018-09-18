{ config, pkgs, ... }:

{
  imports = [
    # Moved out cause it is big
    ./pubkeys.nix

    # Not tracked, so doesn't need to go in per-machine subdir
    ../passwd.nix

    # Portable nice to haves
    ./packages.nix
  ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  networking = {
    # wireless.enable = true;     # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Enable NetworkManager
  };

  # Select internationalisation properties.
  i18n = {
    #consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
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
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

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
  users.extraUsers.jcericson = {
    uid = 1000;
    createHome = true;
    description = "John Cotton Ericson";
    extraGroups = [ "jcericson" "networkmanager" "wheel" ];
    isSystemUser = false;
    isNormalUser = true;
    useDefaultShell = true;
  };
}
