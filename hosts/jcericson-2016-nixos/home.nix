{ ... }:

{
  imports = [
    ../../user
    ../../user/graphical/wayland
    ../../user/video-games.nix
  ];

  xresources.properties = {
    "*.dpi" = 150;
  };

  # TODO get alacritty to respect the above, and remove this.
  programs.alacritty.settings.font.size = 23;

  home.stateVersion = "20.09";
}
