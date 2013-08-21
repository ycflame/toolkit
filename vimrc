set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set nu
syntax on
filetype plugin indent on
set colorcolumn=81
highlight ColorColumn ctermbg=DarkGray
set cursorcolumn

set pastetoggle=<F5>
map <F6> :set number!<CR>
map <F7> :call RunSrc()<CR>
map <F8> :call Pylint()<CR>

" Define RunSrc()
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
" End of RunSrc()

" Define Pylint()
func Pylint()
exec "!pylint %"
endfunc
" End of Pylint()

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
