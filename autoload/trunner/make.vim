let s:makefile_path = ''

function! trunner#make#list_task() abort
  let s:makefile_path = findfile('Makefile', getcwd() . '/;')
  if !filereadable(s:makefile_path)
    return []
  endif
  return map(filter(readfile(s:makefile_path), {i, v ->
  \ v !~# '^\t'
  \ && v !~# '.=.*' 
  \ && v !~# '^\.\?PHONY' 
  \ && v !~# '^FORCE' 
  \ && v !~# '^#' 
  \ && v !=# '' 
  \}), {i, v ->
  \ {
  \   'command': 'make',
  \   'task': trim(matchstr(v, '^.*:'), ':'),
  \   'raw_command': ['make', '-f', s:makefile_path, trim(matchstr(v, '^.*:'), ':')]
  \ }
  \})
endfunction
