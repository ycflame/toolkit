" Load pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Set tab length to 4 spaces
set tabstop=4

" Set indent length to 4 spaces when pressing << or >>
set shiftwidth=4

" Replace tab with spaces
set expandtab

" Delete 4 spaces with one backspace in blank lines
set smarttab

" Show line number
set nu

" Syntax highlight
syntax on

" Filetype detection, plugin files and indent files for specific file types 
filetype plugin indent on

" Highlight the 80th column as max line length and set color
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray

" Highlight the column cursor stands for indent checking and set color
set cursorcolumn
highlight CursorColumn ctermbg=DarkGray

" Highlight searched text
set hls

" Auto find tags file in current project folder
set tags=tags;/

" Toggle NERDTree window
map <F4> :NERDTreeToggle<CR>

" Toggle paste mode
set pastetoggle=<F5>

" Toggle line number
map <F6> :set number!<CR>

" Reserve F7 to run flake8

" Run current script
map <F8> :call RunSrc()<CR>

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
    endif
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
