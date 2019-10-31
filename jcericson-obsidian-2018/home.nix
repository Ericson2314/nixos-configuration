{ ... }:

{
  imports = [
    ../user
  ];

  programs.git.userEmail = "John.Ericson@Obsidian.Systems";

  xresources.properties = {
    "*.dpi" = 120;
  };

  # TODO get alacritty to respect the above, and remove this.
  programs.alacritty.settings.font.size = 4.5;
}
