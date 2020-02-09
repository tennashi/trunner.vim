let s:makefile_path = ''

function! trunner#make#list_task() abort
  let s:makefile_path = findfile('Makefile', '.;')
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
