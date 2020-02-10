{ pkgs, ... }:

{
  imports = [
    ../user
  ];

  programs.git.userEmail = "John.Ericson@Obsidian.Systems";

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
