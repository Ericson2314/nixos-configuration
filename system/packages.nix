{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editors
    (neovim.override { vimAlias = true; })
    # emacs # in user config, due to customization

    # Development
    gitAndTools.tig

    # Admin
    acpi
    file
    gptfdisk
    gparted
    htop
    pciutils
    tree
    wget

    # Nix
    nix-prefetch-scripts
    nixos-option
  ];

  nix = {
    # Don't use unstable if there is a schema change!
    #package = pkgs.nixUnstable;

    settings = {
      sandbox = true;
      substituters = [
        "https://cache.nixos.org/"
        "https://nixcache.reflex-frp.org"
      ];
      trusted-substituters = [
        "https://hydra.nixos.org/"
        "https://hydra.cryp.to"
      ];
      trusted-public-keys = [
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
      ];
    };
    channel.enable = false;
  };
}
