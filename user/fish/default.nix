{ ... }:

{
  programs.fish.enable = true;

  # TODO fix session vars
  programs.fish.interactiveShellInit = ''
    set -e EDITOR
    set -Ux EDITOR vim
  '';

  programs.fish.promptInit = builtins.readFile ./fish_prompt.fish;
}
