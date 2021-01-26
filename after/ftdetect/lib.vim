" detect .lib files as SPICE files instead of cobol
" use `setlocal filetype` instead of `setfiletype` because otherwise the
" filetype will not be re-defined from cobol to spice
autocmd BufRead,BufNewFile *.lib setlocal filetype=spice
