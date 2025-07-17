" vim -Nu <(curl https://init-zhang.github.io/vimrc)

set viminfo=
set noswapfile

syntax off
set hlsearch

set rnu nu
set tabstop=4 shiftwidth=4 expandtab
set autoindent smartindent

set laststatus=2
set showcmd

let mapleader=','

nnoremap <leader>E :E<CR>
nnoremap <leader>e :Te<CR>

let g:netrw_fastbrowse=2

inoremap <expr> <Tab> getline('.')[0 : col('.')-2] =~ '\S' ? "\<C-n>" : "\<Tab>"

