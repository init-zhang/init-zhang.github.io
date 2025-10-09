" vim -Nu <(curl https://init-zhang.github.io/vimrc)

set viminfo=
set noswapfile
filetype plugin off

syntax off
set rnu nu
set hlsearch
set linebreak

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
vnoremap <leader>p "+p

inoremap <expr> <Tab> getline('.')[0 : col('.')-2] =~ '\S' ? "\<C-n>" : "\<Tab>"

nnoremap <C-l> :noh<CR><C-l>

nnoremap <leader>s :set spell!<CR>
nnoremap <leader>z z=
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

autocmd FileType markdown setlocal spell

autocmd FileType netrw setlocal nu rnu
