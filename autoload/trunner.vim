scriptencoding utf-8

let s:task_list = []

function! trunner#setup_task_list() abort
  let s:task_list = trunner#list_task()
endfunction

function! trunner#list_command() abort
  if s:task_list ==# []
    call trunner#error_msg('[trunner] task not found')
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

function! trunner#error_msg(msg) abort
  echohl ErrorMsg
  redraw
  echo a:msg
  echohl None
endfunction
