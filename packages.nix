# Edit this configuration file to define what should be installed on
# the system.  Help is available in the configuration.nix(5) man page
# or the NixOS manual available on virtual console 8 (Alt+F8).

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [ # Shells
      zsh
      
      # Editors
      vim
      emacs

      # Browser
      firefox

      # Development
      # (git.override { guiSupport = true; })
      git

      # Desktop Env
      dmenu
      
      # Bits of Gnome
      # gnome3.gnome_terminal
	  evince

	  termite

      # Admin
      gparted

      # Nix
      nix-repl
    ];

  #nix.binaryCaches = builtins.concatLists [ config.nix.binaryCaches.default [ "https://hydra.nixos.org/" "http://hydra.cryp.to" ] ];
  nix.binaryCaches = [ "http://cache.nixos.org/" "https://hydra.nixos.org/" "http://hydra.cryp.to" ];
}
