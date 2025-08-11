" vim -Nu <(curl https://init-zhang.github.io/vimrc)

set viminfo=
set noswapfile

syntax off
set rnu nu
set hlsearch

set tabstop=4 shiftwidth=4 expandtab smarttab
set autoindent smartindent

set laststatus=2
set showcmd

let mapleader=' '

nnoremap <leader>E :E<CR>
nnoremap <leader>e :Te<CR>
let g:netrw_fastbrowse=2

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

inoremap <expr> <Tab> getline('.')[0 : col('.')-2] =~ '\S' ? "\<C-n>" : "\<Tab>"

nnoremap <C-l> :noh<CR><C-l>
