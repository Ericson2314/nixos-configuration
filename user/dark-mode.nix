{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = true;
    '';
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
  dconf = {
    enable = pkgs.stdenv.isLinux;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/freedesktop/appearance" = {
        color-scheme = 1;
      };
    };
  };
}
