filetype plugin on
filetype indent on

" autoread file when it's changed outside of vim
set autoread

" show line and column numbers at bottom
set ruler
" show line numbers at left, relative to current number
set number
set relativenumber
" show command at bottom
set showcmd
" highlight current line
set cursorline
" highlight matching brace
set showmatch

" hide buffers when they're abandoned
set hid

" make backspace act like it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" show trailing spaces, tabs, and long lines
set listchars=tab:\ \ ,trail:~,extends:>,precedes:<
" set listchars=tab:»\ ,extends:¿,precedes:¿,nbsp:·,trail:·
" set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~
" set showbreak=\\ " [bonus]
set list

" ignore case when searching
set ignorecase

" try to be smart about case when searching
set smartcase

" highlight search results
set hlsearch

" make search act like modern software
set incsearch

set t_Co=256
colorscheme zenburn
syntax enable

" if possible, enable a column at 80 characters
set colorcolumn=80

" use spaces instead of tabs
set expandtab

" be smart about using tabs
set smarttab

" one indent is 4 spaces
set shiftwidth=4
" one tab character is displayed as 4 spaces
"set tabstop=4 " disabled 11/17

" newlines are indented the same as previous line
" superceded by filetype indentation, but gives minimal indentation rules
" for unknown file types
set autoindent
"set smartindent " disabled 11/17

" if Vim version supports it (>= 8), indent wrapped lines
if exists("&breakindent")
    set breakindent
    set showbreak=\ \ " comment so whitespace works
endif

" show autocomplete menu
set wildmenu

" don't redraw unnecessarily
set lazyredraw

" navigate through wrapped lines as expected
nnoremap j gj
nnoremap k gk

" navigate between splits with <C-direction>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" easier buffer navigation
nnoremap gb :ls<CR>:buffer<Space>
nnoremap gB :ls<CR>:sbuffer<Space>

" open new splits below and to the right of existing splits
set splitbelow
set splitright

augroup filetype_c
    " clear previous autocommands
    autocmd!
    " set comment string for c files to //
    autocmd FileType c setlocal commentstring=//\ %s
augroup END

if has('gui_running')
    set guioptions-=T " no toolbar
    set lines=60 columns=108
endif

" put backups, swap files, and undo files in one place (depending on OS)
set backupdir^=~/.vim/backup//
set directory^=~/.vim/swap//
set undodir^=~/.vim/undo//

" Prevent copy/paste problems after exiting vim
" set t_BE=
