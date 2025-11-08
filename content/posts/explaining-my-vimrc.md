+++
date = 2025-11-08
title = 'Explaining My Vimrc'
+++

This is my `.vimrc` as off 2025-11-08. This post will be breaking down the config line by line.

```vimscript
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
```

---

This command allows me to run Vim one time with my config. It doens't depend on `git` and just requires `vim` and `curl`. `-N` is to enable non-compatible mode to ensure the config works correctly.

    " vim -Nu <(curl https://init-zhang.github.io/vimrc)

Here I remove the vim info and swap file, I just don't find them useful.

    set viminfo=
    set noswapfile

For automatic indenting depending on the file type.

    filetype plugin indent on

Enables both relative line numbers and actual file number on the current line.

    set rnu nu

Highlight search results

    set hlsearch

Wrap lines by word and not character, useful for writing.

    set linebreak

Sensible tab behaviour, set tabs to 4 spaces, set shifting to 4 spaces too, expand tab characters into space characters, delete 4 spaces on backspace.

    set tabstop=4 shiftwidth=4 expandtab smarttab

Sensible indent behaviour, such as maintaining tab level when pressing return/enter.

    set autoindent smartindent

Always on status line, I just find useful to have.

    set laststatus=2

Show the latest pressed keys for the current action.

    set showcmd

Create a highlight group with a red background.

    highlight TrailingWhitespace ctermbg=red

Set that highlight group to trailing spaces.

    match TrailingWhitespace /\s\+$/

Set leader key to space.

    let mapleader=' '

Create more convenient keybinds for quitting, save-quitting, saving.

    nnoremap <leader>q :q<CR>
    nnoremap <leader>w :x<CR>
    nnoremap <leader>f :up<CR>

Leader keybinds for opening `netrw` in both the current window or new tab.

    nnoremap <leader>E :E<CR>
    nnoremap <leader>e :Te<CR>

Set netrw to only update directory listings on new directory or netrw refresh.

    let g:netrw_fastbrowse=2

Leader keybinds for clipboard yanking/copying and pasting

    noremap <leader>y "+y
    noremap <leader>p "+p
    noremap <leader>P "+P

Enable keyword competition on tab. If the line is only whitespace, insert a tab, otherwise open keyword competition prompt.

    inoremap <expr> <Tab> getline('.')[0 : col('.')-2] =~ '\S' ? "\<C-n>" : "\<Tab>"

Set refresh window keybind also clears search highlighting.

    nnoremap <C-l> :noh<CR><C-l>

Leader keybind to toggle spell checking

    nnoremap <leader>s :set spell!<CR>

More convenient leader keybind to suggest spelling corrections.

    nnoremap <leader>z z=

Insert mode keybind to autocorrect the last spelling mistakes, choosing the first correction. It also makes the correction into its own undo group (so it can be undone in one undo) and returns the cursor position.

    inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

Enable spell checking by default in only markdown files.

    autocmd FileType markdown setlocal spell

Set relative line numbers and normal line numbers in netrw for easier navigation.

    autocmd FileType netrw setlocal nu rnu

