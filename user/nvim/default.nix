{ pkgs, ... }:

{
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.configure = {
    customRC = builtins.readFile ./init.vim;
  };
  # TODO include other neovim settings
  home.file.".vimrc".source = ./init.vim;

  # EDITOR is actually line editor. Yay history.
  home.sessionVariables.EDITOR = "vim -e";
  # VISUAL is is for full terminal.
  home.sessionVariables.VISUAL = "vim";
}
