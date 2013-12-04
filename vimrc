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

" Highlight the line cursor stands set color
set cursorline
highlight CursorLine ctermbg=DarkGray

set laststatus=2    " Always show the status line

" Format the status line
set statusline=\ %{HasPaste()}%f%m%r%h\ %w\ %l,%c\ %P

"=============================================================================
" Misc
"=============================================================================

set nocompatible  " Don't be compatible with vi

set encoding=utf-8  " Set encoding in Vim
set fileencodings=utf-8,cp936,gbk  " Set encoding order when detecting files

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
augroup DeleteTrailing
    autocmd BufWrite *.py :call DeleteTrailingWS()
    autocmd BufWrite *.coffee :call DeleteTrailingWS()
augroup END

" Turn on paste mode when pasting and turn off after that
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

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

" Open MRU window
noremap <silent><Leader>m :MRU<CR>

" Toggle line number
noremap <silent><Leader>n :set number!<CR>

" Toggle location window
noremap <silent><Leader>e :Errors<CR>
noremap <silent><leader>lc :lcl<CR>
noremap <silent><Leader>ln :lnext<CR>
noremap <silent><Leader>lp :lprev<CR>

" Jump to function definition of current statements
noremap <silent><Leader>d :call GotoFunc()<CR>

" autopep8
noremap <silent><Leader>f :call FormatSrc()<CR>

" Run current script
noremap <silent><Leader>r :call RunSrc()<CR>

" Toggle Spell Checking
noremap <silent><Leader>s :setlocal spell!<CR>

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

"=============================================================================
" Functions
"=============================================================================

" Delete trailing whitespaces
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" Format code style
func! FormatSrc()
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

" Jump to current function definition
func! GotoFunc()
    if &filetype == 'py' || &filetype == 'python'
        exec "?def "
    elseif &filetype == 'c'
        exec "?^{"
        exec "normal k"
    endif
endfunc

" Display PASTE MODE in status line if paste mode is enabled
func! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunc

" Run current file
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

" Toggle paste mode before pasting
func! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunc
