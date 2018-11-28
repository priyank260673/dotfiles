" init vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" vundle packages
Bundle 'gmarik/vundle'
Bundle 'ervandew/supertab'
Bundle 'ctrlp.vim'
Bundle 'ZoomWin'
Bundle 'matchit.zip'
Bundle 'tComment'
Bundle 'vim-airline/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'flazz/vim-colorschemes'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'w0rp/ale'
Bundle 'fatih/vim-go'
"Bundle 'vim-syntastic/syntastic'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'yegappan/grep'
Bundle 'mileszs/ack.vim'
Bundle 'airblade/vim-gitgutter'

"Bundle 'Valloric/YouCompleteMe'
"Bundle 'bronson/vim-trailing-whitespace'
"Bundle 'mxw/vim-jsx'
"Bundle 'kballard/vim-swift'
"Bundle 'plasticboy/vim-markdown'
"Bundle 'mustache/vim-mustache-handlebars'
"Bundle 'slim-template/vim-slim'
"Bundle 'puppetlabs/puppet-syntax-vim'
"Bundle 'elixir-lang/vim-elixir'
"Bundle 'briancollins/vim-jst'
"Bundle 'jszakmeister/vim-togglecursor'
"Bundle 'rking/ag.vim'
"Bundle 'Chun-Yang/vim-action-ag'
"Bundle 'jparise/vim-graphql'

" take in an extra file from the local directory if necessary
if filereadable(glob(".vimrc.local"))
  source .vimrc.local
endif

" vim options
filetype plugin indent on
syntax on
cabbr te tabedit
colorscheme xoria256
set expandtab
set nocompatible
set laststatus=2
set tabstop=4
set shiftwidth=4
set showtabline=4
set softtabstop=4
set number
set wrap
set backspace=0
set t_Co=256
"set colorcolumn=80 " red line and over is error
set textwidth=0
set hlsearch

" turn off vim-markdown folding
let g:vim_markdown_folding_disabled=1

" ag-vim shortcut
map <Leader>f gagiw

" set nonumber
highlight Normal ctermbg=None

" Tags setup
set tags+=~/tags/allTags

if has('cscope')
  set csto=0
  set cst
  set nocsverb
  set cscopetag cscopeverbose

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
      cs add $CSCOPE_DB
  endif
endif

" Put cscope output in quick fix window
set cscopequickfix=s-,c-,d-,i-,t-,e-

"Grep setup
nmap <C-n> :cnext <CR>
nmap <C-p> :cprevious <CR>

"Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Hide menu/toolbar
set guioptions=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Sets how many lines of history VIM has to remember
set history=1000

" " Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" "Always show current position
set ruler

" " Height of the command bar
set cmdheight=2

" " A buffer becomes hidden when it is abandoned
set hid

" " Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
"
" Ignore case when searching
set ignorecase

" " When searching try to be smart about cases 
set smartcase

" " Highlight search results
set hlsearch

" " Don't redraw while executing macros (good performance config)
set lazyredraw
"
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Tlist setup
let Tlist_Show_One_File = 1
set updatetime=500

" Set directory to current buffer
set autochdir 

"Identing
filetype plugin indent on
set smartindent
set autoindent

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 

" ConqueTerm session support
let g:ConqueTerm_SessionSupport = 0

" sets mouse focus on split windown
set mousefocus
set guioptions+=a

" =========== OMNI COMPLETE FEATURES =================== "
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/tags/cppTags
" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_ShowAccess          = 1 "show access in pop-up
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "_GLIBCXX_STD_A", "_GLIBCXX_STD_C"]
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
set omnifunc=syntaxcomplete#Complete
" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q -I _GLIBCXX_NOEXCEPT .<CR>

" =========== MINI BUFFER SET UP=================== "
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Vim diff settings
if &diff                             " only for diff mode/vimdiff
    set diffopt=filler,context:1000000 " filler is default and inserts empty
    "lines for sync
endif

"============= Compile directly off vim ======================="
" For regular compilation of projects
nmap <F9> :call BuildDbg()<cr>
function! BuildDbg()
    set makeprg=make\ -j10\ debug=1
    make
endfunction

"nmap <F10> :call BuildRel()<cr>
"function! BuildRel()
"    set makeprg=make\ -j10
"    make
"endfunction

" Automatically build on save either cpp/h file
" autocmd BufWritePost *.cpp\|*.h make -j10 debug=1

"For building C++ file

nmap <F4> :call MakeCppDbg() <cr>
function! MakeCppDbg()
    set makeprg=g++-8\ -g3\ %\ -o\ %<
    make
endfunction

nmap <F6> :call MakeCppPre() <cr>
function! MakeCppPre()
    set makeprg=g++-8\ -std=c++11\ -E\ -g3\ %\ -o\ /tmp/out.txt
    make
endfunction

"============= Compile directly off vim ======================="
" set cursorline

"============= Stop searching once it hits end of the file ======================="
"set nowrapscan
" Set path for seaching "
" POWERLINE SETUP 
"set rtp+=/home/users/ppatel/TOOLS/powerline/powerline-develop/powerline/bindings/vim
"set laststatus=2
"set t_Co=256
"let g:Powerline_symbols = 'fancy'
"set encoding=utf-8
"set t_Co=256
"set fillchars+=stl:\ ,stlnc:\
"let g:Powerline_mode_V="V·LINE"
"let g:Powerline_mode_cv="V·BLOCK"
"let g:Powerline_mode_S="S·LINE"
"let g:Powerline_mode_cs="S·BLOCK"

"super tab plugin
"let g:SuperTabDefaultCompletionType = "context"

"Nerd tree setup
"let g:NERDTreeWinPos = "right"
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p
nmap <silent> <special> <F2> :NERDTreeToggle<RETURN>

"""""""""""" SIZE OF VIM """""""""""""""""""""""""""
" size of vim
if has("gui_running")
    set lines=65 columns=200
    set guifont=Monospace\ 12
endif

map <space> :BufExplorer<RETURN>
map <F3> :ZoomWin<RETURN>

"""""""""""" GDB """""""""""""""""""""""""""
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly 
nmap <F2> :ConqueGdbVSplit 
nmap <F10> :copen<RETURN>
nmap <F11> :lopen<RETURN>

"""""""""""" VIM-GO  """""""""""""""""""""""""""
let g:go_highlight_trailing_whitespace_error = 0

"""""""""""" ALE  """""""""""""""""""""""""""
"let g:ale_open_list = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
nmap <C-n> :lnext <CR>
nmap <C-p> :lprevious <CR>

"""""""""""" Syntastic  """""""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs=1
"

"let  g:C_UseTool_cmake    = 'yes'
" To enable the saving and restoring of screen positions.
"let g:screen_size_restore_pos = 1
"
"" To save and restore screen for each Vim instance.
"" This is useful if you routinely run more than one Vim instance.
"" For all Vim to use the same settings, change this to 0.
"let g:screen_size_by_vim_instance = 1
""
"" Enable restoring of gvim size last time used
"if has("gui_running")
"    function! ScreenFilename()
"        if has('amiga')
"            return "s:.vimsize"
"        elseif has('win32')
"            return $HOME.'\_vimsize'
"        else
"            return $HOME.'/.vimsize'
"        endif
"    endfunction
"
"    function! ScreenRestore()
"        " Restore window size (columns and lines) and position
"        " from values stored in vimsize file.
"        " Must set font first so columns and lines are based on font size.
"        let f = ScreenFilename()
"        if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
"            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
"            for line in readfile(f)
"                let sizepos = split(line)
"                if len(sizepos) == 5 && sizepos[0] == vim_instance
"                    silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
"                    silent! execute "winpos ".sizepos[3]." ".sizepos[4]
"                    return
"                endif
"            endfor
"        endif
"    endfunction
"
"    function! ScreenSave()
"        " Save window size and position.
"        if has("gui_running") && g:screen_size_restore_pos
"            let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
"            let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
"                        \ (getwinposx()<0?0:getwinposx()) . ' ' .
"                        \ (getwinposy()<0?0:getwinposy())
"            let f = ScreenFilename()
"            if filereadable(f)
"                let lines = readfile(f)
"                call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
"                call add(lines, data)
"            else
"                let lines = [data]
"            endif
"            call writefile(lines, f)
"        endif
"    endfunction
"
"    if !exists('g:screen_size_restore_pos')
"        let g:screen_size_restore_pos = 1
"    endif
"    if !exists('g:screen_size_by_vim_instance')
"        let g:screen_size_by_vim_instance = 1
"    endif
"    autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
"    autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
"endif
"""""""""""" SIZE OF VIM """""""""""""""""""""""""""
"" CSCOPE SETUP
"function! LoadCscope()
"  let db = findfile("cscope.out", "~/tags/;")
"  if (!empty(db))
"    let path = strpart(db, 0, match(db, "/cscope.out$"))
"    set nocscopeverbose " suppress 'duplicate connection' error
"    exe "cs add " . db . " " . path
"    set cscopeverbose
"  endif
"endfunction
"au BufEnter /* call LoadCscope()

