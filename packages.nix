{ config, pkgs, ... }:

{
  nixpkgs.config.firefox =
    { #enableGnomeExtensions = true;
      #enableGoogleTalkPlugin = true;
      enableAdobeFlash = true;
    };

  environment.systemPackages = with pkgs;
    [ # Shells
      zsh

      # Editors
      vim
      # emacs # in user config, due to customization

      # Browser
      firefoxWrapper

      # Development
      (git.override { guiSupport = true; })

      # Desktop Env
      dmenu

      # Bits of Gnome
      # gnome3.gnome_terminal
      evince

      # Terminal emulator
      termite

      # Admin
      acpi
      file
      gparted
      htop
      pciutils
      tree
      wget

      # Nix
      nix-repl
      nix-prefetch-scripts
      strategoPackages018.strategoxt
    ];

  nix = {
    binaryCaches = [
      "http://cache.nixos.org/"
    ];
    trustedBinaryCaches = [
      "https://hydra.nixos.org/"
      "http://hydra.cryp.to"
      "https://ryantrinkle.com:5443"
    ];
    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];
  };
}
