" init vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" vundle packages
Bundle 'gmarik/vundle'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-fugitive'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'yegappan/grep'
Bundle 'airblade/vim-gitgutter'
Bundle 'flazz/vim-colorschemes'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/a.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'skywind3000/asyncrun.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'andymass/vim-matchup'
Bundle 'ludovicchabant/vim-gutentags'
"Bundle 'w0rp/ale'

" Colorschemes "
colorscheme xoria256
let g:airline_theme='alduin'
"let g:airline_powerline_fonts = 1

" take in an extra file from the local directory if necessary
if filereadable(glob(".vimrc.local"))
  source .vimrc.local
endif
" take in an extra file from the local directory if necessary
if filereadable(glob(".vimrc.plugin"))
  source .vimrc.local
endif

" Add path so that we can find files"
set path+=/home/ppatel/
set path+=/home/ppatel/git/example/sapphire/
set path+=/home/ppatel/git/example/sapphire/hawk/

" Ctags for navigation
set tags=~/tags/allTags

" Set wildmenu
""set wildmode=longest,list,full
set wildmode=longest,full
set wildmenu

" vim options
set cursorline
set encoding=utf-8
filetype on
filetype plugin indent on
filetype plugin on
syntax on
cabbr te tabedit

" Tab settings
set autoindent autowrite noexpandtab tabstop=4 shiftwidth=4
set nocompatible
set laststatus=2
set number
set wrap
set backspace=0
set t_Co=256
set textwidth=0
set hlsearch
"set colorcolumn=80 " red line and over is error
"set softtabstop=4

" turn off vim-markdown folding
let g:vim_markdown_folding_disabled=1


" Setup cscope
if has('cscope')
  set csto=0
  set cst
  set nocsverb
  "set cscopetag cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
      " else add database pointed to by environment
  elseif $CSCOPE_DB != ""
      "cs add $CSCOPE_DB
      cs add ~/tags/cscope.out
  endif
endif

" Put cscope output in quick fix window
set cscopequickfix=s-,c-,d-,i-,t-,e-

"Grep setup
nmap <C-n> :cnext <CR>
nmap <C-p> :cprevious <CR>

" Hide menu/toolbar
set guioptions=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General

" " Sets how many lines of history VIM has to remember
set history=1000
" " Set to auto read when a file is changed from the outside
set autoread
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" "Always show current position
set ruler
" " Height of the command bar
set cmdheight=1
" " A buffer becomes hidden when it is abandoned
set hid
" " Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" " When searching try to be smart about cases 
set smartcase
" " Highlight search results
set hlsearch
" " Don't redraw while executing macros (good performance config)
set lazyredraw
" " For regular expressions turn magic on
set magic
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Disable matching parentheses
let g:loaded_matchparen=1
" Set line numbers
set nu
" Show matching brackets
set showmatch
set matchpairs+=<:>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Tlist setup
let Tlist_Show_One_File = 1
set updatetime=500

" Set directory to current buffer
set autochdir 
"Identing
set smartindent
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" ConqueTerm session support
let g:ConqueTerm_SessionSupport = 0

" sets mouse focus on split windown
set mousefocus
set guioptions+=a

"Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Vim diff settings
if &diff                             " only for diff mode/vimdiff
	colorscheme xoria256
    set diffopt=filler,context:1000000 " filler is default and inserts empty
	set noro
endif

map <space> :BufExplorer<RETURN>

"============= FUNCTION KEY MAPPING ======================="
nmap <F2> :e ~/scratchpad.txt  <cr>
" For regular compilation of projects
nmap <F3> :call MakeCppDbg() <cr>
function! MakeCppDbg()
    set makeprg=/usr/bin/g++-7\ -std=c++17\ -E\ -pthread\ -lrt\ -g3\ -o\ /tmp/preprocess.txt
    make
endfunction
nmap <F4> :call MakeCppDbg() <cr>
function! MakeCppDbg()
    set makeprg=/usr/bin/g++-7\ -std=c++17\ -pthread\ -lrt\ -g3\ %\ -o\ %<
    make
endfunction
" Resize windows"
nmap <F5> :vertical resize -1  <cr>
nmap <F6> :vertical resize +1  <cr>
nmap <F7> :resize -1  <cr>
nmap <F8> :resize +1  <cr>
nmap <F9> :AsyncRun -save=2 ~/bin/buildApp.sh btecdrop-test<cr>
nmap <F10> :AsyncRun -save=2 ~/bin/buildAppRel.sh btecdrop-test<cr>
""nmap <F9> :AsyncRun -save=2 ~/bin/buildApp.sh instinet_downloader<cr>
nmap <F11> :call BuildDbg()<cr>
function! BuildDbg()
    cd /home/ppatel/git/example/sapphire/build/debug/
    "set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
    set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ btec_drop
    make | copen | resize 25
endfunction
nmap <F12> :call BuildRel()<cr>
function! BuildRel()
    cd /home/ppatel/git/example/sapphire/build/debug/
    "set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
    set makeprg=make\ -j3\ VERBOSE=1\ btec_drop
    make | copen | resize 25
endfunction



