" vim -Nu <(curl https://init-zhang.github.io/vimrc)

set viminfo=
set noswapfile
filetype plugin indent on

set rnu nu
set hlsearch
set linebreak

set tabstop=4 shiftwidth=4 expandtab smarttab
set autoindent smartindent

set laststatus=2
set showcmd

highlight TrailingWhitespace ctermbg=red
match TrailingWhitespace /\s\+$/

let mapleader=' '

nnoremap <leader>q :q<CR>
nnoremap <leader>w :x<CR>
nnoremap <leader>f :up<CR>

nnoremap <leader>E :E<CR>
nnoremap <leader>e :Te<CR>
let g:netrw_fastbrowse=2

noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P

inoremap <expr> <Tab> getline('.')[0 : col('.')-2] =~ '\S' ? "\<C-n>" : "\<Tab>"

nnoremap <C-l> :noh<CR><C-l>

nnoremap <leader>s :set spell!<CR>
nnoremap <leader>z z=
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

autocmd FileType markdown setlocal spell
autocmd FileType netrw setlocal nu rnu
