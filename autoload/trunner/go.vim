let s:path_sep = fnamemodify('.', ':p')[-1:]

function! trunner#go#list_task() abort
  let l:go_proj_dir = fnamemodify(findfile('go.mod', getcwd() . '/;'), ':p:h')
  if !isdirectory(l:go_proj_dir)
    return []
  endif
  let l:main_go_path = findfile('main.go', l:go_proj_dir . s:path_sep . '**')
  if !filereadable(l:main_go_path)
    return []
  endif

  return [
  \ {'command': 'go', 'task': 'run', 'raw_command': ['go', 'run', l:main_go_path]},
  \ {'command': 'go', 'task': 'test', 'raw_command': ['go', 'test', l:go_proj_dir . s:path_sep . '...']},
  \ {'command': 'go', 'task': 'build', 'raw_command': ['go', 'build', l:main_go_path]},
  \]
endfunction
