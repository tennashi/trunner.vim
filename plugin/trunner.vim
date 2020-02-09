" goem.vim
" Author: tennashi <yuya.gt@gmail.com>
" Licence: MIT

scriptencoding utf-8
if exists('g:loaded_trunner') && g:loaded_trunner
  finish
endif
let g:loaded_trunner = 1

command! Trunner call trunner#list_command()

