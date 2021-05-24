" steampipe.vim - basic vim/steampipe integration
" Maintainer: HashiVim <https://github.com/hashivim>

if exists('b:did_ftplugin') || v:version < 700 || &compatible
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

" j is a relatively recent addition; silence warnings when setting it.
setlocal formatoptions-=t formatoptions+=croql
silent! setlocal formatoptions+=j
let b:undo_ftplugin = 'setlocal formatoptions<'

if !has('patch-7.4.1142')
  " Include hyphens as keyword characters so that a keyword appearing as
  " part of a longer name doesn't get partially highlighted.
  setlocal iskeyword+=-
  let b:undo_ftplugin .= ' iskeyword<'
endif

if get(g:, 'steampipe_fold_sections', 0)
  setlocal foldmethod=syntax
  let b:undo_ftplugin .= ' foldmethod<'
endif

" Set the commentstring
setlocal commentstring=#%s
let b:undo_ftplugin .= ' commentstring<'

if get(g:, 'steampipe_align', 0) && exists(':Tabularize')
  inoremap <buffer> <silent> = =<Esc>:call steampipe#align()<CR>a
  let b:undo_ftplugin .= '|iunmap <buffer> ='
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save

if !exists('g:steampipe_binary_path')
  let g:steampipe_binary_path='steampipe'
endif

if !executable(g:steampipe_binary_path)
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

command! -nargs=+ -complete=custom,steampipe#commands -buffer Steampipe
  \ execute '!'.g:steampipe_binary_path.' '.<q-args>

command! -nargs=0 -buffer SteampipeFmt call steampipe#fmt()
let b:undo_ftplugin .= '|delcommand Steampipe|delcommand SteampipeFmt'

if get(g:, 'steampipe_fmt_on_save', 0)
  augroup vim.steampipe.fmt
    autocmd!
    autocmd BufWritePre *.sp call steampipe#fmt()
  augroup END
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
