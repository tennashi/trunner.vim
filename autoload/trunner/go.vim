let g:trunner#go#default_options = {
\ 'run': [],
\ 'test': [],
\}

function! trunner#go#list_task() abort
  let l:go_proj_dir = fnamemodify(findfile('go.mod', '.;'), ':p:h')
  let l:path_sep = fnamemodify('.', ':p')[-1:]
  let l:main_go_path = findfile('main.go', l:go_proj_dir . l:path_sep . '**')
  if l:main_go_path ==# ''
    return []
  endif

  return [
  \ {'command': 'go',
  \  'task': 'run',
  \  'raw_command': extend(['go', 'run'], add(g:trunner#go#default_options['run'], l:main_go_path))
  \ },
  \ {'command': 'go',
  \  'task': 'test',
  \  'raw_command': extend(['go', 'test'], add(g:trunner#go#default_options['test'], l:go_proj_dir . l:path_sep . '...'))
  \ },
  \]
endfunction
