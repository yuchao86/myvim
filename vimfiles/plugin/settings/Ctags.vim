let Tlist_Ctags_Cmd = '/usr/local/Cellar/ctags/5.8/bin/ctags'
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_WinWidth = 40
map <F4> :TlistToggle<cr>
set tags+=./tags;/
set tags+=gems.tags
autocmd FileType ruby let &l:tags = pathogen#legacyjoin(pathogen#uniq(pathogen#split(&tags) + map(split($GEM_PATH,':'),'v:val."/gems/*/tags"')))
"set tags=/home/gree/tags
set tags=~/mnt/bliu02/tags
