let s:cpo_save = &cpoptions
set cpoptions&vim

" Ensure no conflict with arguments from the environment
let $SP_CLI_ARGS_fmt=''

function! steampipe#fmt() abort
  " Save the view.
  let curw = winsaveview()

  " Make a fake change so that the undo point is right.
  normal! ix
  normal! "_x

  " Execute `steampipe fmt`, redirecting stderr to a temporary file.
  let tmpfile = tempname()
  let shellredir_save = &shellredir
  let &shellredir = '>%s 2>'.tmpfile
  silent execute '%!'.g:steampipe_binary_path.' fmt -no-color -'
  let &shellredir = shellredir_save

  " If there was an error, undo any changes and show stderr.
  if v:shell_error != 0
    silent undo
    let output = readfile(tmpfile)
    echo join(output, "\n")
  endif

  " Delete the temporary file, and restore the view.
  call delete(tmpfile)
  call winrestview(curw)
endfunction

function! steampipe#align() abort
  let p = '^.*=[^>]*$'
  if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
    Tabularize/=.*/l1
    normal! 0
    call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

function! steampipe#commands(ArgLead, CmdLine, CursorPos) abort
  let commands = [
    \ 'init',
    \ 'validate',
    \ 'plan',
    \ 'apply',
    \ 'destroy',
    \ 'console',
    \ 'fmt',
    \ 'force-unlock',
    \ 'get',
    \ 'graph',
    \ 'import',
    \ 'login',
    \ 'logout',
    \ 'output',
    \ 'providers',
    \ 'refresh',
    \ 'show',
    \ 'state',
    \ 'taint',
    \ 'test',
    \ 'untaint',
    \ 'version',
    \ 'workspace'
  \ ]
  return join(commands, "\n")
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save
