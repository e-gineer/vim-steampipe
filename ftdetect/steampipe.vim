" vint: -ProhibitAutocmdWithNoGroup
" By default, Vim associates .sp files with Spice - tell it not to.
silent! autocmd! filetypedetect BufRead,BufNewFile *.sp
autocmd BufRead,BufNewFile *.sp,*.spc set filetype=steampipe.sql
