scriptencoding utf-8
"*****************************************************************************
"" SQL ftplugin
"*****************************************************************************

" plugin settings
"" tcomment_vim
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif
let g:tcomment_types.sql = '-- %s'
let g:tcomment_types.mysql = '-- %s'
