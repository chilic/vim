" Editing
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" ColorScheme
Plug 'phanviet/vim-monokai-pro'
Plug 'joshdick/onedark.vim'

" Autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
let g:deoplete#enable_at_startup = 1

" Programming
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'bfrg/vim-c-cpp-modern'
