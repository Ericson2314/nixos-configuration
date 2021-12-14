{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = builtins.readFile ./fish_prompt.fish;
  xdg.configFile."fish/functions".source = ./functions;
}
