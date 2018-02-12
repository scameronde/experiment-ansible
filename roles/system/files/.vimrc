" style and behaviour of search
set hlsearch
set incsearch

execute pathogen#infect()

" syntax parsing
syntax on

" tabs and spaces
set expandtab
set shiftwidth=2
set smarttab

" show line numbers
set number
" set relativenumber


" style of status line
set laststatus=2 "show the status line
set statusline=%-10.3n  "buffer number

" style and keys for diff-merge
let mapleader = ','
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" style and behaviour of file explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

" behaviour for autocompletion of files and paths
set wildmenu
set wildmode=list:full
set path+=**
set wildignorecase
set wildignore=target

