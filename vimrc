
"author:	yuchao86@gmail.com
" date : 2012-08-17
set fileencodings=utf-8,gbk,utf-16
set number
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

filetype plugin on

au FileType php setlocal dict+=~/.vim/doc/php_funclist.txt
"au FileType c setlocal dict+=~/.vim/doc/c_funclist.txt

if !exists('g:AutoComplPop_Behavior')
    let g:AutoComplPop_Behavior = {}
    let g:AutoComplPop_Behavior['php'] = []
    call add(g:AutoComplPop_Behavior['php'], {
            \   'command'   : "\<C-x>\<C-o>", 
            \   'pattern'   : printf('\(->\|::\|\$\)\k\{%d,}$', 0),
            \   'repeat'    : 0,
            \})
endif

""""""""""""""""""""""""""""""
" lookupfile setting
""""""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "��������2���ַ��ſ�ʼ����
let g:LookupFile_PreserveLastPattern = 0        "�������ϴβ��ҵ��ַ���
let g:LookupFile_PreservePatternHistory = 1     "���������ʷ
let g:LookupFile_AlwaysAcceptFirst = 1          "�س��򿪵�һ��ƥ����Ŀ
let g:LookupFile_AllowNewFiles = 0              "���������������ڵ��ļ�
if filereadable("./filenametags")                "����tag�ļ�������
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"ӳ��LookupFileΪ,lk
nmap <silent> <leader>lk :LUTags<cr>
"ӳ��LUBufsΪ,ll
nmap <silent> <leader>ll :LUBufs<cr>
"ӳ��LUWalkΪ,lw
nmap <silent> <leader>lw :LUWalk<cr>


set autochdir
"call pathogen:infect()
" �ڴ��ļ���ʱ����
 let g:syntastic_check_on_open=1
" "phpcs��tab4���ո񣬱���ο�ʹ��CodeIgniter���
 let g:syntastic_phpcs_conf = "--tab-width=4 --standard=CodeIgniter"

let makeprg = "php -l -d error_reporting=E_ALL -d display_errors=1 -d error_log='' ".shellescape(expand('%')) 

let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1

call pathogen#runtime_append_all_bundles()
call pathogen#infect()
call pathogen#helptags()


let g:user_zen_settings = {
  \  'indentation' : '  ',
  \  'perl' : {
  \    'aliases' : {
  \      'req' : 'require '
  \    },
  \    'snippets' : {
  \      'use' : "use strict\nuse warnings\n\n",
  \      'warn' : "warn \"|\";",
  \    }
  \  }
  \}

let g:user_zen_expandabbr_key = '<c-e>'

let g:use_zen_complete_tag = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 1 
let g:syntastic_auto_jump=1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
