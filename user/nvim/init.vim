noremap ; :
noremap <Space> i
noremap <CR> i
noremap j h
noremap i k
noremap k j
imap <S-Space> <Esc>
imap <C-Space> <Esc>

colorscheme desert
syntax on
set hlsearch
set mouse=a
set nobackup
set noswapfile
set number
set tabstop=4
set shiftwidth=4
set smartcase
set autoindent
set copyindent
set virtualedit=onemore
set gdefault
set ruler

au BufEnter *.arr set syntax=pyret
au BufEnter *.arr set expandtab

au BufEnter *.hs set shiftwidth=2
au BufEnter *.hs set softtabstop=2
au BufEnter *.hs set expandtab

" au BufEnter *.nix set syntax=nix
