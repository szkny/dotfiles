scriptencoding utf-8
"*****************************************************************************
"" markdown ftplugin
"*****************************************************************************

" auto command
aug delimitMate
    if exists('delimitMate_version')
        au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
    endif
aug END
