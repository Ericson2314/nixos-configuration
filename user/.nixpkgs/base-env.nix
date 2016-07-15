with (import <nixpkgs> {});
{
  inherit gimp;
  inherit (gimpPlugins) resynthesizer;

  inherit hexchat;

  inherit myEmacs;
  #inherit musescore;

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
