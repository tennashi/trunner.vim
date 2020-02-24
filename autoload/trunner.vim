scriptencoding utf-8

let s:task_list = []
let s:target_list = ['make']
let s:trunner_winid = 0

function! trunner#setup_task_list() abort
  let s:task_list = trunner#list_task()
endfunction

function! trunner#list_command() abort
  if s:task_list ==# []
    call trunner#error_msg('[trunner] task not found')
    return
  endif
  let s:trunner_winid = popup_menu(s:menu_list(), {
  \  'callback': function('s:selected'),
  \  'filter': function('s:filter'),
  \})
endfunction

function! s:filter(id, key) abort
  if a:key ==# 'e'
    return s:edit_raw_command(a:id)
  endif
  return popup_filter_menu(a:id, a:key)
endfunction

function! s:edit_raw_command(id) abort
    let l:cur_line = line('.', a:id)
    let l:cur_cmd = join(s:task_list[l:cur_line - 1]['raw_command'])
    let l:raw_cmd = input('exec: ', l:cur_cmd)
    if l:raw_cmd ==# ''
      return v:true
    endif
    let s:task_list[l:cur_line - 1]['raw_command'] = split(l:raw_cmd)
    call popup_close(s:trunner_winid, l:cur_line)
    return v:true
endfunction

function! s:menu_list() abort
  return map(copy(s:task_list), {i, v ->
  \ toupper(v['command']) . ': ' . v['task']})
endfunction

function! trunner#list_task() abort
  let l:list = []
  for l:t in s:target_list
    let l:list += trunner#{l:t}#list_task()
  endfor
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
  call term_start(l:cmd['raw_command'])
endfunction

function! trunner#error_msg(msg) abort
  echohl ErrorMsg
  redraw
  echo a:msg
  echohl None
endfunction
