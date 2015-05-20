with (import <nixpkgs> {});
{
  inherit gimp;

  inherit myEmacs;
  inherit (haskellPackages) cabal2nix;

  inherit meld;
  inherit gitg;

  inherit qemu;
  inherit gdb;

  inherit ncdu;
  inherit unison;
  inherit htop;

  inherit xsel;

  inherit p7zip;
  inherit unzip;
}
