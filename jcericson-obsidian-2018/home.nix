{ ... }:

{
  imports = [
    ../user
  ];

  programs.git.userEmail = "John.Ericson@Obsidian.Systems";

  xresources.properties = {
    "*.dpi" = 120;
  };
}
