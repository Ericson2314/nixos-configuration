{ pkgs, ... }:

{
  imports = [
    ../../user
    ../../user/graphical/wayland
    ../../user/video-games.nix
    ../../user/work.nix
  ];

  # Auto-detection would otherwise pick a scale I do not want here.
  wayland.windowManager.niri.settings._children = [
    {
      output = {
        _args = [ "DP-1" ];
        scale = 1;
      };
    }
  ];

  xresources.properties = {
    "*.dpi" = 120;
  };

  home.packages = with pkgs; [
  ];

  # TODO get alacritty to respect the above, and remove this.
  programs.alacritty.settings.font.size = 13;

  home.stateVersion = "20.09";
}
