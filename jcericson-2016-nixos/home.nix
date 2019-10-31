{ ... }:

{
  imports = [
    ../user
  ];

  xresources.properties = {
    "*.dpi" = 150;
  };

  # TODO get alacritty to respect the above, and remove this.
  programs.alacritty.settings.font.size = 5.5;
}
