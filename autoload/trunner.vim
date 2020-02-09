scriptencoding utf-8

let s:task_list = []

function! trunner#list_command() abort
  let s:task_list = trunner#list_task()
  if s:task_list ==# []
    return
  endif
  call popup_menu(s:menu_list(), {
  \  'callback': function('s:selected'),
  \})
endfunction

function! s:menu_list() abort
  return map(copy(s:task_list), {i, v ->
  \ toupper(v['command']) . ': ' . v['task']})
endfunction

function! trunner#list_task() abort
  let l:list = trunner#make#list_task()
  return l:list
endfunction

function! s:selected(id, result) abort
  if a:result == -1
    return
  endif
  call trunner#run(a:result - 1)
endfunction

function! trunner#run(selected_idx) abort
  let l:cmd = s:task_list[a:selected_idx]
  call trunner#{l:cmd['command']}#execute(l:cmd['task'])
endfunction
