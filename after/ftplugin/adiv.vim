if exists("b:did_ftplugin")
    finish
endif

" syntax is reset by $VIMRUNTIME/syntax/syntax.vim, so this is used to work
" around the issue. This sets the syntax setting up after the autocommmands in
" syntax.vim are run.
" For details, see https://vi.stackexchange.com/questions/16470/setting-syntax-in-ftplugin
augroup adiv_options
    autocmd!
    " when Syntax autocommands are run, set the following ADIV options at the
    " end
    autocmd Syntax <buffer> call SetAdivOptions()
augroup END

function! SetAdivOptions()
    " remove autocmds in ftplugin_adiv to prevent recursion
    " (otherwise setting 'syntax' will fire the autocmd again and again)
    autocmd! adiv_options
    setlocal nowrap
    set syntax=conf
endfunction
