{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish.promptInit = builtins.readFile ./fish_prompt.fish;
  xdg.configFile."fish/functions".source = ./functions;
}
