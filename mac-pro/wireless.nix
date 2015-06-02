{ config, lib, pkgs, ... }:

{
  boot.extraModulePackages = [
    config.boot.kernelPackages.broadcom_sta
  ];

  boot.initrd.availableKernelModules = [
    "brcmsmac"
  ];
}
