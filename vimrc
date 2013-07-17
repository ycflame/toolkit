set tabstop=4
set shiftwidth=4
set expandtab
set nu
syntax on
filetype plugin indent on
set pastetoggle=<F5>
map <F6> :set number!<CR>

map <F12> :call RunSrc()<CR>
"定义RunSrc()
func RunSrc()
exec "w"
if &filetype == 'c'
exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
elseif &filetype == 'cpp' || &filetype == 'hpp'
exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
elseif &filetype == 'perl'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'py'||&filetype == 'python'
exec "!python %"
elseif &filetype == 'java'
exec "!astyle --style=java --suffix=none %"
endif
exec "e! %"
endfunc
"结束定义RunSrc
