{ pkgs, ... }:

{
  # I don't like bash, but I want history in nix shell.
  programs.bash = {
    enable = true;
    historyControl = [
      "erasedups"
      "ignorespace"
    ];
    historyFileSize = 10000000;
    historySize = 10000000;
  };
}
