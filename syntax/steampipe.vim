" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-steampipe

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" Identifiers are made up of alphanumeric characters, underscores, and
" hyphens.
if has('patch-7.4.1142')
    syn iskeyword a-z,A-Z,48-57,_,-
endif

syn case match

" A block is introduced by a type, some number of labels - which are either
" strings or identifiers - and an opening curly brace.  Match the type.
syn match spBlockIntroduction /^\s*\zs\K\k*\ze\s\+\(\("\K\k*"\|\K\k*\)\s\+\)*{/ contains=spBlockType
syn keyword spBlockType contained data locals module output provider resource steampipe variable mod control benchmark query options connection

syn keyword spValueBool true false on off yes no

syn keyword spTodo         contained TODO FIXME XXX BUG TF-UPGRADE-TODO
syn region  spComment      start="/\*" end="\*/" contains=spTodo,@Spell
syn region  spComment      start="#" end="$" contains=spTodo,@Spell
syn region  spComment      start="//" end="$" contains=spTodo,@Spell

""" misc.
syn match spValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match spValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match spBraces        "[\[\]]"


""" skip \" and \\ in strings.
syn region spValueString   start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=spStringInterp
syn region spStringInterp  matchgroup=spBraces start=/\(^\|[^$]\)\$\zs{/ end=/}/ contained contains=ALL

""" heredoc, which is usually SQL
syntax include @SQL syntax/sql.vim
syn region spHereDocText   start=/<<-\?\z([a-z0-9A-Z]\+\)/ end=/^\s*\z1/ contains=@SQL

"" Functions.
syn match spFunction "[a-z0-9]\+(\@="

""" HCL2
syn keyword spRepeat         for in
syn keyword spConditional    if
syn keyword spType           string bool number object tuple list map set any
syn keyword spValueNull      null

" enable block folding
syn region spBlockBody matchgroup=spBraces start="{" end="}" fold transparent

hi def link spComment           Comment
hi def link spTodo              Todo
hi def link spBraces            Delimiter
hi def link spBlockType         Structure
hi def link spValueBool         Boolean
hi def link spValueDec          Number
hi def link spValueHexaDec      Number
hi def link spValueString       String
hi def link spHereDocText       String
hi def link spFunction          Function
hi def link spRepeat            Repeat
hi def link spConditional       Conditional
hi def link spType              Type
hi def link spValueNull         Constant

let b:current_syntax = 'steampipe'

let &cpoptions = s:cpo_save
unlet s:cpo_save
