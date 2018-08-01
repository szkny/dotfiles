scriptencoding utf-8
"*****************************************************************************
"" SQL ftplugin
"*****************************************************************************

setlocal filetype=mysql


" plugin settings
"" tcomment_vim
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif
let g:tcomment_types.mysql = '-- %s'
