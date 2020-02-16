" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Disable swap files
set nobackup
set noswapfile

" Boilerplate Stuff
" set relativenumber
set number
set wrap
set spell
set showcmd
set wildmenu
set lazyredraw

" Tabbing stuff
set tabstop=4
set softtabstop=4
set noexpandtab
set shiftwidth=4

" Folding Stuff
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za

" Searching Stuff
set incsearch
set hlsearch
set showmatch
set smartcase


" Utility Stuff
filetype indent on
syntax enable
colorscheme escuro

" Movement Stuff
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

" Super Undo
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Session Save
nnoremap <leader>s :mksession<CR>

" Local vimrcs
set exrc
set secure
