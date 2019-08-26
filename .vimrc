" init vundle
if $HOME == "/home/ppatel"
	let laptop_mode = 0
else
	let laptop_mode = 1
endif

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
"Bundle 'junegunn/fzf'
"Bundle 'junegunn/fzf.vim'
""Bundle 'ludovicchabant/vim-gutentags'

" Set tags
set tags=~/tags/allTags,~/tags/cppTags

"Colorschemes "
colorscheme xoria256_mine
let g:airline_theme='alduin'

" Set wildmenu
""set wildmode=longest,list,full
set wildmode=longest,full
set wildmenu

" vim options
set nocursorline
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
set matchpairs+=':'

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

" Vim diff settings
if &diff                             " only for diff mode/vimdiff
	set diffopt=filler,context:1000000 " filler is default and inserts empty
	set diffopt+=iwhite
	set noro
endif

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
		set makeprg=g++-8\ -std=c++17\ -g3\ %\ -o\ %<
		make
	endfunction

	nmap <f4> :call MakeCppPre () <cr>
	function! MakeCppPre ()
		set makeprg=g++-8\ -std=c++17\ -E\ -g3\ %\ -o\ /tmp/out.txt
		make
	endfunction 
else
	" take in an extra file from the local directory if necessary
	if filereadable(glob("~/extra_git/mydotfiles/dotfiles/.vimrc.plugin"))
		source ~/extra_git/mydotfiles/dotfiles/.vimrc.plugin
	endif

	" Add path so that we can find files"
	set path+=/home/ppatel/
	set path+=/home/ppatel/git/example/sapphire/
	set path+=/home/ppatel/git/example/sapphire/sapphire/
	set path+=/home/ppatel/git/example/sapphire/hawk/

	map <F3> :call MakeCppDbg() <cr>
	function! MakeCppDbg()
		set makeprg=/usr/bin/g++-7\ -std=c++17\ -E\ -pthread\ -lrt\ -g3\ -o\ /tmp/preprocess.txt
		make
	endfunction
	map <F4> :call MakeCppDbg() <cr>
	function! MakeCppDbg()
		set makeprg=/usr/bin/g++-7\ -std=c++17\ -pthread\ -lrt\ -g3\ -fsanitize=address\ -fsanitize=leak\ %\ -o\ %<
		make
	endfunction
	""function! BuildDbg()
	""	cd /home/ppatel/git/example/sapphire/build/debug/
	""	set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
	""	make | copen | resize 25
	""endfunction
	map <F9> :AsyncRun -save=2 ~/bin/buildApp.sh 
	map <F10> :AsyncRun -save=2 ~/bin/buildAppRel.sh 
	map <F11> :call BuildDbg()<cr>
	function! BuildDbg()
		cd /home/ppatel/git/example/sapphire/build/debug/
		"set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
		set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ btec_drop
		make | copen | resize 75
	endfunction
	map <F12> :call BuildRel()<cr>
	function! BuildRel()
		cd /home/ppatel/git/example/sapphire/build/debug/
		"set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
		set makeprg=make\ -j3\ VERBOSE=1\ btec_drop
		make | copen | resize 75
	endfunction

	nmap <C-c> :qa <cr>
	imap <C-c> <Esc>
	" Current build 
	map <C-z> :AsyncRun -save=2 ~/bin/buildApp.sh instinetrouter-test <cr>
endif

"============= COMMON FUNCTION KEY MAPPING ======================="
nmap <F2> :e ~/scratchpad.txt  <cr>
" For regular compilation of projects
" Resize windows"
nmap <F5> :vertical resize -1  <cr>
nmap <F6> :vertical resize +1  <cr>
nmap <F7> :resize -1  <cr>
nmap <F8> :resize +1  <cr>

""============= COMMON FUNCTION KEY MAPPING ======================="
"function! ExpandCMacro()
"  "get current info
"  let l:macro_file_name = "__macroexpand__" . tabpagenr()
"  let l:file_row = line(".")
"  let l:file_name = expand("%")
"  let l:file_window = winnr()
"  "create mark
"  execute "normal! Oint " . l:macro_file_name . ";"
"  execute "w"
"  "open tiny window ... check if we have already an open buffer for macro
"  if bufwinnr( l:macro_file_name ) != -1
"    execute bufwinnr( l:macro_file_name) . "wincmd w"
"    setlocal modifiable
"    execute "normal! ggdG"
"  else
"    execute "bot 10split " . l:macro_file_name
"    execute "setlocal filetype=cpp"
"    execute "setlocal buftype=nofile"
"    nnoremap <buffer> q :q!<CR>
"  endif
"  "read file with gcc
"  silent! execute "r!gcc -E " . l:file_name
"  "keep specific macro line
"  execute "normal! ggV/int " . l:macro_file_name . ";$\<CR>d"
"  execute "normal! jdG"
"  "indent
"  execute "%!indent -st -kr"
"  execute "normal! gg=G"
"  "resize window
"  execute "normal! G"
"  let l:macro_end_row = line(".")
"  execute "resize " . l:macro_end_row
"  execute "normal! gg"
"  "no modifiable
"  setlocal nomodifiable
"  "return to origin place
"  execute l:file_window . "wincmd w"
"  execute l:file_row
"  execute "normal!u"
"  execute "w"
"  "highlight origin line
"  let @/ = getline('.')
"endfunction
"autocmd FileType cpp nnoremap <leader>m :call ExpandCMacro()<CR>

