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
    # The leading newline makes the generated code not be one big line,
    # which does seem to be valid Lua, but is hard for me to read.
    extraLuaConfig = ''

      require('lspconfig').clangd.setup({})
    '';
  };

  # TODO include other neovim settings
  home.file.".vimrc".source = ./init.vim;
}
