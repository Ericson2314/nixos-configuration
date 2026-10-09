{ ... }:

{
  imports = [
    ../../user
    ../../user/graphical/wayland
    ../../user/video-games.nix
    ../../user/work.nix
  ];

  programs.alacritty.settings.font.size = 16;

  home.stateVersion = "20.09";
}
