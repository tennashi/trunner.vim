" goem.vim
" Author: tennashi <yuya.gt@gmail.com>
" Licence: MIT

scriptencoding utf-8
if exists('g:loaded_trunner') && g:loaded_trunner
  finish
endif
let g:loaded_trunner = 1

command! Trunner call trunner#list_command()

nnoremap <Plug>(trunner-run) :<C-u>call trunner#list_command()

augroup PluginTrunner
  autocmd!
  autocmd VimEnter * call trunner#setup_task_list()
augroup END

