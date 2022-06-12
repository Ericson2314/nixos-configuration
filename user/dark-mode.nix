{ ... }:

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
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
  dconf.settings."org/freedesktop/appearance" = {
    color-scheme = 1;
  };
}
