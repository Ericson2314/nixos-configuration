{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
    ];
  };

  # TODO include other neovim settings
  home.file.".vimrc".source = ./init.vim;
}
