with (import <nixpkgs> {});
{
  inherit gimp;

  inherit myEmacs;
  inherit (haskellPackages) cabal2nix;

  inherit meld;

  inherit qemu;
  inherit gdb;

  inherit ncdu;
  inherit unison_2_40;
  inherit htop;

  inherit xsel;

  inherit p7zip;
  inherit unzip;
  inherit unrar;
}
