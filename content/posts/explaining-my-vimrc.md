+++
date = 2025-11-08
title = 'Explaining My Vimrc'
tags = ['vim', 'config']
description = 'Line by line breakdown of my vimrc file.'
aliases = ['vimrc']
+++

This is my `.vimrc` as of 2025-12-10. It's a vanilla Vim setup that I believe is decently minimal.

```
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
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/

let mapleader=' '

nnoremap <leader>q :q<CR>
nnoremap <leader>w :x<CR>
nnoremap <leader>f :up<CR>
nnoremap <leader>d :bd<CR>

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
inoremap <C-l> <c-g>u<Esc>[s1z=gi<c-g>u

autocmd FileType markdown setlocal spell
autocmd FileType netrw setlocal nu rnu
```

---

```
set viminfo=
set noswapfile
```

Disable the `viminfo` and swap file, I've never found them useful.

```
filetype plugin indent on
```

Enable language specific plugins and indentation.

```
set rnu nu
```

Enable relative line numbers whilst keeping the current line number.

```
set hlsearch
```

Highlight searches.

```
set linebreak
```

Wrap lines via words rather than characters, I find this wrapping more natural.

```
set tabstop=4 shiftwidth=4 expandtab smarttab
```

Set tabs to 4 spaces and delete 4 spaces at a time.

```
set autoindent smartindent
```

Enable smart automatic indentation.

```
set laststatus=2
set showcmd
```

Always show the status bar and current command being typed. I find the both information to have.

```
highlight TrailingWhitespace ctermbg=red
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
```

Create a highlight group that highlights trailing spaces in red. An autocommand because buffers spawned from Netrw lack the highlight group, so this just ensures they have it.

```
let mapleader=' '
```

Set leader key to space.

```
nnoremap <leader>q :q<CR>
nnoremap <leader>w :x<CR>
nnoremap <leader>f :up<CR>
nnoremap <leader>d :bd<CR>
```

More convenient leader key bindings for quit, save and quit, save, and delete current buffer. `f` and `d` are notably on the home row.

```
nnoremap <leader>E :E<CR>
nnoremap <leader>e :Te<CR>
```

Leader key bindings to open Netrw in the current window or new tab respectively.

```
let g:netrw_fastbrowse=2
```

Enable fast directory browsing for Netrw, which only obtains directory listings when the directory has never been seen before (or on refresh).

```
noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P
```

Convenient leader key bindings for yanking to and pasting from system clipboard.

```
inoremap <expr> <Tab> getline('.')[0 : col('.')-2] =~ '\S' ? "\<C-n>" : "\<Tab>"
```

Text completion on non-empty lines when pressing tab. The condition checks if the character is not whitespace, pressing `<C-n>` for text completion or a tab otherwise.

```
nnoremap <C-l> :noh<CR><C-l>
```

Also clear last search highlight when refreshing display.

```
nnoremap <leader>s :set spell!<CR>
nnoremap <leader>z z=
```

Leader key bindings for toggling spell check and displaying spelling options.

```
inoremap <C-l> <c-g>u<Esc>[s1z=gi<c-g>u
```

Spell check the last misspelling with the first suggestion, whilst retaining cursor position. `<c-g>u` creates and finishes a new undo group, so I can do undo the suggestion in one go. `[s` take the cursor to the last misspelling, `1z=` uses the first suggestion. `gi` brings you back to the last place insertion mode was exited, in insert mode.

```
autocmd FileType markdown setlocal spell
```

Enable spell check on markdown files.

```
autocmd FileType netrw setlocal nu rnu
```

Enable relative line numbers because Netrw disables the setting.
