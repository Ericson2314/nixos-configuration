{ pkgs, ... }:

{
  imports = [
    ../../user
    ../../user/graphical.nix
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
  programs.alacritty.settings.font.size = 4.5;
}
