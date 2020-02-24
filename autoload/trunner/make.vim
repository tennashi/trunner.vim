let s:makefile_path = ''
let g:trunner#make#default_options = []

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
  \ {
  \   'command': 'make',
  \   'task': trim(matchstr(v, '^.*:'), ':'),
  \   'raw_command': expand(['make', '-f', s:makefile_path], add(g:trunner#make#default_options, trim(matchstr(v, '^.*:'), ':'))),
  \ }
  \})
endfunction
