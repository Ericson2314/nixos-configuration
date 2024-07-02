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
  ];

  # TODO get alacritty to respect the above, and remove this.
  programs.alacritty.settings.font.size = 23;

  home.stateVersion = "20.09";
}
