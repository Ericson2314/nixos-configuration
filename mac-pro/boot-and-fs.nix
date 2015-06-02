# Everything releated to booting and filesystems
{ config, pkgs, ... }:

{
  boot.initrd.kernelModules =
    [ # Specify all kernel modules that are necessary for mounting the root
      # filesystem.
      "btrfs" # "ata_piix"
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Add filesystem entries for each partition that you want to see
  # mounted at boot time.  This should include at least the root
  # filesystem.

  fileSystems."/" =                              # where you want to mount the device
    { device = "/dev/disk/by-label/NixOS-btrfs"; # the device
      fsType = "btrfs";                          # the type of the partition
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };

  #### List swap partitions activated at boot time.
  ###swapDevices =
  ###  [ { device = "/dev/disk/by-label/swap"; }
  ###  ];
}
