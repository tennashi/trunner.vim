let s:makefile_path = ''

function! trunner#make#list_task() abort
  let s:makefile_path = s:find_makefile()
  if s:makefile_path ==# ''
    return []
  endif
  return map(filter(readfile(s:makefile_path), {i, v ->
  \ v !~# '^\t'
  \ && v !~# '.=.*' 
  \ && v !~# '^\.\?PHONY' 
  \ && v !~# '^FORCE' 
  \ && v !=# '' 
  \}), {i, v ->
  \ { 'command': 'make', 'task': trim(matchstr(v, '^.*:'), ':') }
  \})
endfunction

function! trunner#make#execute(task) abort
    call term_start(['make', '-f', s:makefile_path, a:task])
endfunction

function! s:find_makefile() abort
  try
    let l:path = findfile('Makefile', '.;')
    if l:path ==# ''
      throw 'not found'
    endif
    return l:path
  catch 'not found'
    echohl ErrorMsg
    redraw
    echo '[trunner] Makefile is not found.'
    echohl None
  endtry
endfunction
