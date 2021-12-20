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
Bundle 'Valloric/YouCompleteMe'
Bundle 'skywind3000/asyncrun.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'andymass/vim-matchup'
Bundle 'bfrg/vim-cpp-modern'
Bundle 'inkarkat/vim-mark'
Bundle 'inkarkat/vim-ingo-library'
Bundle 'christoomey/vim-tmux-navigator'
"Bundle 'kien/ctrlp.vim'
"Bundle 'vim-scripts/a.vim'
"Bundle 'octol/vim-cpp-enhanced-highlight'
"Bundle 'junegunn/fzf'
"Bundle 'junegunn/fzf.vim'
"Bundle 'ludovicchabant/vim-gutentags'

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
		"cs add ~/tags/cscope.out
		"cs add ~/tags/master_cscope.out
	endif
endif

"packadd termdebug
"let g:termdebug_wide=1
"autocmd filetype cpp nnoremap <F6> :Termdebug %:r<CR><c-w>2j<c-w>L<c-w>h
"nmap <C-q> <c-w>2j<c-w>L<c-w>h

"==========================================================================
" Set sappshire tags
set tags=~/tags/allTags,~/tags/cppTags
cs add ~/tags/cscope.out
set path+=/home/ppatel/git/example/sapphire/**

" Set master tags
" set tags=~/tags/masterTags,~/tags/cppTags
" cs add ~/tags/master_cscope.out
" set path+=/home/ppatel/git/master_repo/example/sapphire/**

" Set release tags
" set tags=~/tags/relNrcTags,~/tags/cppTags
" cs add ~/tags/relnrc_cscope.out
" set path+=/home/ppatel/git/release_nrc_repo/example/sapphire/**

" Set dev work tags
" set tags=~/tags/devTags,~/tags/cppTags
" cs add ~/tags/dev_cscope.out
" set path+=/home/ppatel/git/dev_work/example/sapphire/**
"==========================================================================

"Colorschemes "
"colorscheme xoria256_mine
colorscheme gruvbox
let g:airline_theme='alduin'
"highlight Cursor guifg=white guibg=black
"highlight iCursor guifg=white guibg=steelblue
"set guicursor=n-v-c:block-Cursor
"set guicursor+=i:ver100-iCursor
"set guicursor+=n-v-c:blinkon0
"set guicursor+=i:blinkwait10

" Set wildmenu
""set wildmode=longest,list,full
set wildmode=longest,full
set wildmenu

" vim options
"set cursorline
set encoding=utf-8
filetype on
filetype plugin indent on
filetype plugin on
syntax on

" Tab settings
set autoindent autowrite noexpandtab tabstop=4 shiftwidth=4
set nocompatible
set laststatus=2
set nu
set wrap
set backspace=0
set t_Co=256
set textwidth=0
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
"set hlsearch
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
	set wrap 
	autocmd FilterWritePre * if &diff | setlocal wrap< | endif
	colorscheme gruvbox
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
		set makeprg=g++\ -std=c++20\ -g3\ %\ -o\ %<
		make
	endfunction

	nmap <f4> :call MakeCppPre () <cr>
	function! MakeCppPre ()
		set makeprg=g++\ -std=c++20\ -E\ -g3\ %\ -o\ /tmp/out.txt
		make
	endfunction 
else
	" take in an extra file from the local directory if necessary
	if filereadable(glob("~/extra_git/mydotfiles/dotfiles/.vimrc.plugin"))
		source ~/extra_git/mydotfiles/dotfiles/.vimrc.plugin
	endif

	map <F3> :call MakeCppDbg() <cr>
	function! MakeCppDbg()
		set makeprg=/usr/bin/g++\ -std=c++20\ -E\ -pthread\ -lrt\ -g3\ -o\ /tmp/preprocess.txt
		make
	endfunction
	map <F4> :call MakeCppDbg() <cr>
	function! MakeCppDbg()
		set makeprg=/usr/bin/g++\ -std=c++20\ -pthread\ -lrt\ -g3\ -fsanitize=address\ -fsanitize=leak\ %\ -o\ %<
		make
	endfunction
	""function! BuildDbg()
	""	cd /home/ppatel/git/example/sapphire/build/debug/
	""	set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
	""	make | copen | resize 25
	""endfunction
	map <F9> :AsyncRun -save=2 ~/bin/buildIce.sh<cr>
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
	map <C-z> :AsyncRun -save=2 ~/bin/buildApp.sh eurexrouter_condor <cr>
endif

" Added for menu configuration
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

"============= COMMON FUNCTION KEY MAPPING ======================="
"nmap <F2> :e ~/scratchpad.txt  <cr>
" For regular compilation of projects
" Resize windows"
nmap <F5> :vertical resize -1  <cr>
nmap <F6> :vertical resize +1  <cr>
nmap <F7> :resize -1  <cr>
nmap <F8> :resize +1  <cr>
nnoremap gf :vertical wincmd F<CR>
set splitright

"set errorformat =%E%f:%l:%c:\ %trror:\ %m,%-C,%-Z%p^
"set errorformat +=%E%f:%l:%c:\ %tning:\ %m
"set errorformat +=%C%.%#
"set errorformat +=note:\ 
"set errorformat -=*\.cmake*

"autocmd BufWritePost * :AsyncRun ~/bin/buildApp.sh regulatory_reader_cfe_boe cfeboerouter_condor followtopofbook2 strategy_nodeimpl-test
autocmd insertleave * update
au textchanged,insertleave * nested if &readonly == 0 | silent! update | endif

augroup todo
  autocmd!
  autocmd Syntax * call matchadd(
              \ 'Search',
              \ '\v\W\zs<(NOTE|INFO|TODO|FIXME|CHANGED|BUG|HACK)>'
              \ )
augroup END


""============= DEBUGGER SETTING ======================="
packadd termdebug
let g:termdebug_wide=1
nnoremap <C-K> <c-w>w
"autocmd filetype cpp nnoremap <F2> :Termdebug %:r<CR><c-w>2j<c-w>L<c-w>h
"nnoremap <F2> :Termdebug %:r<CR><c-w>2j<c-w>L<c-w>h
"nmap <C-q> <c-w>2j<c-w>L<c-w>h
"
""============= HIGHLIGT SPLIT WINDOW ======================="
set cul
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

""============= COMMON FUNCTION KEY MAPPING ======================="
"augroup quickfix
"    autocmd!
"    autocmd QuickFixCmdPost [^l]* cwindow
"    autocmd QuickFixCmdPost l* lwindow
"augroup END

""============= ZOOM TOGGLE ======================="
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

""============= COMMON FUNCTION KEY MAPPING ======================="
"function! ExpandCMacro()
"  "get current info
"  let l:macro_file_name = "__macroexpand__".tabpagenr()
"  let l:file_row = line('.')
"  let l:file_name = expand('%')
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
"
"autocmd FileType h nnoremap <leader>m :call ExpandCMacro()<CR>
"autocmd FileType hpp nnoremap <leader>m :call ExpandCMacro()<CR>
"autocmd FileType ipp nnoremap <leader>m :call ExpandCMacro()<CR>
"autocmd FileType cpp nnoremap <leader>m :call ExpandCMacro()<CR>
