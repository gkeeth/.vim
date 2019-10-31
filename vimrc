" general vim settings ----------------------------------------------------{{{
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

" make search act like modern software -- highlight matches as you type
" (before pressing enter)
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

" open new splits below and to the right of existing splits
set splitbelow
set splitright

" keep 10 lines between cursor and bottom/top of screen
set scrolloff=10

" }}}

" custom bindings ---------------------------------------------------------{{{
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

" press <leader>ev to edit $MYVIMRC in new split
nnoremap <leader>ev :split $MYVIMRC<CR>
" press <leader>sv to re-source $MYVIMRC
nnoremap <leader>sv :source $MYVIMRC<CR>
" press <leader>sf to source current file
nnoremap <leader>sf :source %<CR>

" press <leader>tw to delete all trailing whitespace
" restores previous search afterwards
" TODO: restore window using winsaveview() and winrestview()
" also look at :keeppatterns and :keepjumps
" apparently, search history is preserved when leaving a function as well
" so restoring search history is unnecessary if e.g. a Preserve() function is 
" created.
" See https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
nnoremap <leader>tw :let _s=@/<bar>%s/\s\+$//e<bar>let @/=_s<CR>
" }}}

" SETTINGS FOR LEARN VIMSCRIPT THE HARD WAY -------------------------------{{{
let mapleader="\\"
let maplocalleader="\\"

" surround with quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>ll
vnoremap <leader>' <esc>a'<esc>`<i'<esc>`>ll

" use jk to exit insert mode
inoremap jk <esc>

augroup filetype_markdown
    autocmd!
    " note the regex used here is flawed because it will match on -=-=-=
    " (etc), rather than just ----- or ======
    autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^[-=]\\{2,}$\r:nohlsearch\rkvg_"<cr>
    autocmd FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^[-=]\\{2,}$\r:nohlsearch\rg_vk0"<cr>
    "autocmd FileType markdown onoremap <buffer> ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
    "autocmd FileType markdown onoremap <buffer> ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>
augroup END

augroup filetype_vim
    autocmd!
    " for vim files, fold based on markers
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" motion to edit email addresses
onoremap in@ :<c-u>execute "normal! /\S\\+@\S\\+\\.[a-z]\\{2,}\r:nohlsearch\rviW"<cr>

" open previous buffer in a horizontal split
nnoremap <leader>sp :<c-u>execute "rightbelow split" bufname("#")<cr>

" mapping to delete two lines, with each deletion separately undoable
nnoremap <leader>d ddi<c-g>u<esc>dd

" highlight trailing whitespace as an error
nnoremap <leader>w :<c-u>match Error /\v\s$/<cr>
" unhighlight trailing whitespace
nnoremap <leader>W :<c-u>match none<cr>

" automatically use magic mode when searching
nnoremap / /\v
nnoremap ? ?\v

" stop highlighting search results
nnoremap <leader>S :nohlsearch<cr>

" :grep for word under cursor (replaced by grep-operator.vim)
" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:15copen<cr>

" toggle fold column
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>

function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=2
    endif
endfunction

" toggle quickfix window
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" }}}

" filetype settings (TODO: move to a filetype plugin) ---------------------{{{
augroup filetype_c
    " clear previous autocommands
    autocmd!
    " set comment string for c files to //
    autocmd FileType c setlocal commentstring=//\ %s
augroup END

augroup filetype_python
    " clear previous autocommands
    autocmd!
    " bind F4 to run current python script
    autocmd FileType python nnoremap <buffer> <F4> :w \| exec '!clear; python' shellescape(@%, 1)<CR>
    " simpler version:
    autocmd FileType python nnoremap <buffer> <F4> :!python %<cr>
augroup END

augroup filetype_lev_tim
    autocmd!
    " bind F5 to fix checksum
    autocmd FileType lev,tim nnoremap <F5> :exec '!/proj/93k/com/timing_level_fix_checksum.pl ' . shellescape(@%, 1)<cr>
augroup END

augroup filetype_binl
    autocmd!
    command! HammersmithToHighgate
                \ bufdo %s/wavetable 6/wavetable 10/ |
                \ %s/(pa_08)/(BCLK_pa_08_pc_09)/ |
                \ %s/(\zs\zepc_05/SYNC_/ |
                \ %s/(\zs\zepc_01/SIO1_/ |
                \ %s/(\zs\zepc_08/SIO4_/ |
                \ %s/(\zs\zetwi0_scl/SCL_/ |
                \ %s/(\zs\zetwi0_sda/SDA_/ |
                \ %s/(\zs\zepa_01/MISO_/ |
                \ %s/(\zs\zepa_02/MOSI_/ |
                \ %s/(\zs\zepa_00/SCK_/ |
                \ %s/(\zs\zepc_13/ADR1_/ |
                \ %s/(\zs\zepc_14/ADR2_/ |
                \ %s/(\zs\zepc_10/IRQ_/ |
                \ %s/(hadc_vrefp)/(hadc0_vrefp)/
    "autocmd FileType binl nnorem"ap <F4> 
augroup END
" }}}

" ctags -------------------------------------------------------------------{{{
augroup ctags
    " autocommands related to ctags
    " this will automatically append new tags to an existing tags file.
    " To create a tags file, run ctags -R .
    "
    " clear previous autocommands
    autocmd!
    " if a tags file exists, append new tags to it every time the file is
    " saved
    " NOTE: this will not remove tags referring to deleted code!
    autocmd BufWritePost *
        \ if filereadable('tags') |
        \       call system('ctags -a '.shellescape(expand('%'))) |
        \ endif
augroup END

" create a ctags file for all source files in current directory (recursive)
command! CreateTagFile silent execute '!ctags -R .' <BAR> redraw! <BAR> echo 'Created tag file'

" press F2 to create ctags file
nnoremap <silent> <F2> :CreateTagFile<CR>
" }}}

" setup fonts/window size for gvim ----------------------------------------{{{
if has('gui_running')
    set guioptions-=T " no toolbar
    " this is annoying when re-sourcing vimrc after resizing window
    " set lines=60 columns=108
    if has('gui_win32')
        set guifont=Consolas:h10:cANSI
        set linespace=1
    endif
endif
" }}}

" put backups, swap files, and undo files in one place (depending on OS) --{{{
if has("win32")
    set backupdir^=~/vimfiles/backup//
    set directory^=~/vimfiles/swap//
    set undodir^=~/vimfiles/undo//
else " linux
    set backupdir^=~/.vim/backup//
    set directory^=~/.vim/swap//
    set undodir^=~/.vim/undo//
endif
" }}}

" stupid workarounds for the environment ----------------------------------{{{
" Prevent copy/paste problems after exiting vim (ADI cad environment)
set t_BE=
" }}}
