"=============================================================================
" General Looking
"=============================================================================

set nu              " Show line number
syntax on           " Syntax highlight

" Highlight the 80th column as max line length and set color
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray

" Highlight the column cursor stands for indent checking and set color
set cursorcolumn
highlight CursorColumn ctermbg=DarkGray

" Returns true if paste mode is enabled
func! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunc

set laststatus=2    " Always show the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w   " Format the status line

"=============================================================================
" Misc
"=============================================================================
set tabstop=4       " Set tab length to 4 spaces
set shiftwidth=4    " Set indent length to 4 spaces when pressing << or >>
set expandtab       " Replace tab with spaces
set smarttab        " Delete 4 spaces with one backspace in blank lines

let g:pyindent_open_paren = '&sw'  " indent 4 spaces when continuing lines 

" Filetype detection, plugin files and indent files for specific file types 
filetype plugin indent on

set ignorecase      " Case-insensitive search
set smartcase       " Case-sensitive search if any caps
set hls             " Highlight searched text

" Return to last edit position when opening files (You want this!)
augroup RememberPosition
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
augroup END

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

augroup DeleteTrailing
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWrite *.coffee :call DeleteTrailingWS()
augroup END

" Turn on paste mode when pasting and turn off after that
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

func! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunc

"=============================================================================
" Insert Mode Key Mappings
"=============================================================================

" Ctrl-e: Go to end of line
inoremap <c-e> <esc>A
" Ctrl-a: Go to begin of line
inoremap <c-a> <esc>I

"=============================================================================
" All Mode Key Mappings
"=============================================================================

" Set leader key to ,
let mapleader = ","

" Toggle NERDTree window
noremap <Leader>t :NERDTreeToggle<CR>

" Open MRU window
noremap <Leader>m :MRU<CR>

" Toggle line number
noremap <Leader>n :set number!<CR>

" Toggle line number
noremap <silent><Leader>e :Errors<CR>
noremap <silent><leader>lc :lcl<CR>
noremap <silent><Leader>ln :lnext<CR>
noremap <silent><Leader>lp :lprev<CR>

" autopep8
noremap <silent><Leader>f :call FormartSrc()<CR>

" Define FormartSrc()
func FormartSrc()
exec "w"
if &filetype == 'c'
exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
elseif &filetype == 'cpp' || &filetype == 'hpp'
exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
elseif &filetype == 'perl'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'py'||&filetype == 'python'
exec "r !autopep8 -i --aggressive %"
elseif &filetype == 'java'
exec "!astyle --style=java --suffix=none %"
elseif &filetype == 'jsp'
exec "!astyle --style=gnu --suffix=none %"
elseif &filetype == 'xml'
exec "!astyle --style=gnu --suffix=none %"
endif
exec "e! %"
endfunc

" Run current script
noremap <Leader>r :call RunSrc()<CR>

" Define RunSrc()
func! RunSrc()
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

"=============================================================================
" Plugin settings
"=============================================================================

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" ctags
set tags=tags;/  " Auto find tags file in current project folder

" syntastic
let g:syntastic_python_checkers=['flake8']  " set syntastic checker to flake8
let g:syntastic_python_flake8_args="--ignore=E501" " ignore line too long
