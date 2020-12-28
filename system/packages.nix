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
  ];

  nix = {
    # Don't use unstable if there is a schema change!
    #package = pkgs.nixUnstable;
    useSandbox = true;
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nixcache.reflex-frp.org"
    ];
    trustedBinaryCaches = [
      "https://hydra.nixos.org/"
      "https://hydra.cryp.to"
    ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];
    nixPath = let
      nixpkgs = builtins.toPath ../dep/nixpkgs;
    in [
      ("nixos=" + nixpkgs)
      ("nixpkgs=" + nixpkgs)
      ("nixos-hardware=" + builtins.toPath ../dep/nixos-hardware)
      "nixos-config=/etc/nixos/configuration.nix"
    ];
  };
}
