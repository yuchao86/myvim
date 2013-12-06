"author:	yuchao86@gmail.com
" date : 2012-08-17

"基本配置
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"设置折叠样式
set foldmethod=indent
"设置颜色为desert模式
colorscheme desert
"高亮当前行
set cul

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
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
let g:LookupFile_TagExpr = '"./filenametags"'
endif
"映射LookupFile为,lk
nmap <silent> <leader>lk :LUTags<cr>
"映射LUBufs为,ll
nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
nmap <silent> <leader>lw :LUWalk<cr>


set autochdir
"call pathogen:infect()
" 在打开文件的时候检查
 let g:syntastic_check_on_open=1
" "phpcs，tab4个空格，编码参考使用CodeIgniter风格
 let g:syntastic_phpcs_conf = "--tab-width=4 --standard=CodeIgniter"

let makeprg = "php -l -d error_reporting=E_ALL -d display_errors=1 -d error_log='' ".shellescape(expand('%')) 

let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1

"call pathogen#runtime_append_all_bundles()
"call pathogen#infect()
"call pathogen#helptags()


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

setlocal omnifunc=javacomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType java set completefunc=javacomplete#CompleteParamsInf
autocmd FileType java inoremap <expr><CR> pumvisible()?"\<C-Y>":"<CR>"


function! RemovePairs()
    let l:line = getline(".")
    let l:previous_char = l:line[col(".")-1] "get the location previous char

    if index(["(","[","{"], l:previous_char) != -1
        let l:original_pos = getpos(".")
        execute "normal %"
        let l:new_pos = getpos(".")

        if l:original_pos == l:new_pos
            execute "normal! a\<BS>"
            return
        end

        let l:line2 = getline(".")
        if len(l:line2) == col(".")
            execute "normal! v%xa"
        else
            execute "normal! v%xi"
        end
     else
         execute "normal! a\<BS>"
     end
endfunction

function! RemoveNextDoubleChar(char)
    let l:line = getline(".")
    let l:next_char = l:line[col(".")]

    if a:char == l:next_char
        execute "normal! l"
    else
        execute "normal! i" . a:char . ""
    end
 endfunction


imap { {}<ESC>i<CR><ESC>V<O
imap ( ()<ESC>i

inoremap <BS> <ESC>:call RemovePairs()<CR>a
"inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
"inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
"inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

" PHP 自动完成
" 设置自动完成的监听方式：尾部添加一个字母和清除一个字母
set complete-=k complete+=k
" 设置字典补全文件
set dictionary=~/.vim/doc/php_funclist.txt
set dictionary=~/.vim/doc/c_funclist.txt

" 使用 tab 键自动完成或尝试自动完成
function! InsertTabWrapper()
    let col=col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<TAB>"
    else
        return "\<C-N>"
    endif
endfunction

" 重新映射 tab 键到 InsertTabWrapper 函数
inoremap <TAB> <C-R>=InsertTabWrapper()<CR>


function! TabPos_ActivateBuffer(num)
    let s:count = a:num 
	exe "tabfirst"
	exe "tabnext" s:count  
endfunction

function! TabPos_Initialize()
    for i in range(1, 9) 
        exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>"
    endfor
    exe "map <M-0> :call TabPos_ActivateBuffer(10)<CR>"
endfunction

autocmd VimEnter * call TabPos_Initialize()






