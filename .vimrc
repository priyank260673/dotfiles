" init vundle
let laptop_mode = 1
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
Bundle 'junegunn/fzf'
Bundle 'junegunn/fzf.vim'

" Colorschemes "
colorscheme xoria256_mine
let g:airline_theme='alduin'

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
"set softtabstop=4

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

" Show matching brackets
set showmatch
set matchpairs+=<:>

" Set directory to current buffer
set autochdir 
"Identing
set smartindent

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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

" take in an extra file from the local directory if necessary
if filereadable(glob(".vimrc.local"))
	source .vimrc.local
endif
if (laptop_mode)
	" take in an extra file from the local directory if necessary
	if filereadable(glob("~/git/dotfiles/.vimrc.plugin"))
		source ~/git/dotfiles/.vimrc.plugin
	endif

	let g:airline_powerline_fonts = 1
	" For regular compilation of projects
	nmap <C-c> :call MakeCppDbg() <cr>
	function! MakeCppDbg()
		set makeprg=g++-8\ -g3\ %\ -o\ %<
		make
	endfunction

	nmap <f4> :call MakeCppPre () <cr>
	function! MakeCppPre ()
		set makeprg=g++-8\ -std=c++17\ -e\ -g3\ %\ -o\ /tmp/out.txt
		make
	endfunction 
else
	" Add path so that we can find files"
	set path+=/home/ppatel/
	set path+=/home/ppatel/git/example/sapphire/
	set path+=/home/ppatel/git/example/sapphire/hawk/

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
	""function! BuildDbg()
	""	cd /home/ppatel/git/example/sapphire/build/debug/
	""	set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
	""	make | copen | resize 25
	""endfunction
	nmap <F9> :AsyncRun -save=2 ~/bin/buildApp.sh btecdrop-test<cr>
	nmap <F10> :AsyncRun -save=2 ~/bin/buildAppRel.sh btecdrop-test<cr>
endif

"============= FUNCTION KEY MAPPING ======================="
nmap <F2> :e ~/scratchpad.txt  <cr>
" For regular compilation of projects
" Resize windows"
nmap <F5> :vertical resize -1  <cr>
nmap <F6> :vertical resize +1  <cr>
nmap <F7> :resize -1  <cr>
nmap <F8> :resize +1  <cr>
