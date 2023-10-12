{ pkgs, ... }:

{
  imports = [
    ../../user
    ../../user/graphical/wayland.nix
    ../../user/video-games.nix
    ../../user/work.nix
  ];

  xresources.properties = {
    "*.dpi" = 120;
  };

  home.packages = with pkgs; [
    zoom-us
    tdesktop
  ];

  # TODO get alacritty to respect the above, and remove this.
  programs.alacritty.settings.font.size = 17;

  home.stateVersion = "20.03";
}
