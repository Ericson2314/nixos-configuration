# Everything releated to booting and filesystems
{ config, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_pci"
    "ata_piix"
    "firewire_ohci"
    "usb_storage"
    "sd_mod"
    "sr_mod"
  ];

  boot.initrd.kernelModules = [
    # Specify all kernel modules that are necessary for mounting the root
    # filesystem.
    "btrfs" # "ata_piix"
  ];

  boot.loader.grub = {
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

  # Add filesystem entries for each partition that you want to see
  # mounted at boot time.  This should include at least the root
  # filesystem.

  fileSystems."/" = {                    # where you want to mount the device
    device = "/dev/disk/by-label/nixos"; # the device
    fsType = "btrfs";                    # the type of the partition
    # options = "data=journal";
  };

  fileSystems."/winhome/" = {            # where you want to mount the device
    device = "/dev/disk/by-label/home";  # the device
    fsType = "ntfs";                     # the type of the partition
    # options = "data=journal";
  };


  # List swap partitions activated at boot time.
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
