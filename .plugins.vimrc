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
Plug 'stamblerre/gocode', { 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh'

" Programming
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'bfrg/vim-c-cpp-modern'

" Config
" NerdTree {
    if isdirectory(plugged_dir . '/nerdtree')
        map <C-e> <plug>NERDTreeTabsToggle<CR>
        map <leader>e :NERDTreeToggle<CR>
        nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeWinSize = 40
        let NERDTreeMinimalUI = 1
        let NERDTreeIgnore=['\.DS_Store', '\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '^\.vscode', '^__pycache__$']
        let NERDTreeShowHidden=1
    endif
" }

" Deoplete.nvim {
    if isdirectory(plugged_dir . '/deoplete.nvim')
        let g:deoplete#enable_at_startup = 1
    endif
" }
