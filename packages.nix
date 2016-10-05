{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Shells
    zsh

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
    termite.terminfo

    # Nix
    nix-repl
    nix-prefetch-scripts
    #strategoPackages018.strategoxt # It's broken
  ];

  nix = {
    package = pkgs.nixUnstable;
    binaryCaches = [
      "http://cache.nixos.org/"
    ];
    trustedBinaryCaches = [
      "https://hydra.nixos.org/"
      "http://hydra.cryp.to"
      "https://nixcache.reflex-frp.org"
    ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];
  };
}
