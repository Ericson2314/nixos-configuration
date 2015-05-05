# Edit this configuration file to define what should be installed on
# the system.  Help is available in the configuration.nix(5) man page
# or the NixOS manual available on virtual console 8 (Alt+F8).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./wireless.nix
      ./passwd.nix
      ./touchpad.nix
      ./packages.nix
    ];

  boot.initrd.kernelModules =
    [ # Specify all kernel modules that are necessary for mounting the root
      # filesystem.
      "btrfs" # "ata_piix"
    ];

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  boot.loader.grub =
    {
      enable = true;                       # Enable Grub
      version = 2;                         # Use the GRUB 2 boot loader
      device = "/dev/sda";                 # Define on which hard drive you want to install Grub.

      extraEntries = ''

        set gfxmode=1680x1050,1400x1050,640x480

        menuentry 'Windows Vista (loader)' --class windows --class os {
          insmod part_msdos
          insmod ntfs
          set root='hd0,msdos1'
          # parttool $ {root} hidden-
          chainloader +1
        }
      '';
    };

  networking =
    { hostName = "John-Laptop-Nix";        # Define your hostname.
      # wireless.enable = true;            # Enable Wireless. # use NetworkManager instead
      networkmanager.enable = true;        # Enable NetworkManager
    };

  # Add filesystem entries for each partition that you want to see
  # mounted at boot time.  This should include at least the root
  # filesystem.

  fileSystems."/" =                        # where you want to mount the device
    { device = "/dev/disk/by-label/nixos"; # the device
      fsType = "btrfs";                    # the type of the partition
      # options = "data=journal";
    };

  fileSystems."/winhome/" =                # where you want to mount the device
    { device = "/dev/disk/by-label/home";  # the device
      fsType = "ntfs";                     # the type of the partition
      # options = "data=journal";
    };


  # List swap partitions activated at boot time.
  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];

  # Select internationalisation properties.
  i18n =
    { consoleFont = "lat9w-16";
      consoleKeyMap = "us";
      defaultLocale = "en_US.UTF-8";
    };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh =
    { enable = true;
      ports = [ 20202 ];
      forwardX11 = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };

  # Enable CUPS to print documents.
  services.printing =
    { enable = true;
      #drivers = [ pkgs.gutenprint pkgs.hplip ];
      #clientConf = ''
      #  ServerName printhost.cs.brown.edu
      #'';
    };

  # Enable the X11 windowing system.
  services.xserver =
    { enable = true;
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
  users.extraUsers.john =
    { uid = 1000;
      createHome = true;
      home = "/home/john";
      description = "John Cotton Ericson";
      extraGroups = [ "john" "networkmanager" "wheel" ];
      isSystemUser = false;
      useDefaultShell = true;
    };

}
