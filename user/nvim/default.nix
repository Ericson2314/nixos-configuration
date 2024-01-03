{ pkgs, ... }:

{
  programs.neovim.enable = true;
  programs.neovim.vimAlias = true;
  programs.neovim.extraConfig = builtins.readFile ./init.vim;
  # TODO include other neovim settings
  home.file.".vimrc".source = ./init.vim;
}
