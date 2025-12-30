{ pkgs, ... }:

{
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = builtins.readFile ./fish_prompt.fish;

  # Swap ctrl and alt left/right arrow keys, backspace, and delete
  programs.fish.binds = {
    "ctrl-right".command = "nextd-or-forward-token";
    "ctrl-left".command = "prevd-or-backward-token";
    "alt-right".command = "forward-word";
    "alt-left".command = "backward-word";
    "ctrl-backspace".command = "backward-kill-token";
    "alt-backspace".command = "backward-kill-word";
    "ctrl-delete".command = "kill-token";
    "alt-delete".command = "kill-word";
  };

  programs.fish.functions = {
    notify = builtins.readFile ./functions/notify.fish;
    git-filter-sed = builtins.readFile ./functions/git-filter-sed.fish;
  };
}
