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
Bundle 'tmsvg/pear-tree'
Bundle 'Valloric/YouCompleteMe'
Bundle 'skywind3000/asyncrun.vim'
"Bundle 'w0rp/ale'

" Colorschemes "
colorscheme xoria256
"colorscheme burnttoast256
let g:airline_theme='alduin'

" take in an extra file from the local directory if necessary
if filereadable(glob(".vimrc.local"))
  source .vimrc.local
endif

" Add path so that we can find files"
set path+=/home/ppatel/git/example/sapphire/
set path+=/home/ppatel/git/example/sapphire/hawk/

" Ctags for navigation
set tags=~/tags/allTags

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

" ag-vim shortcut
"map <Leader>f gagiw

" set nonumber
highlight Normal ctermbg=None

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
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
    set diffopt=filler,context:1000000 " filler is default and inserts empty
    "lines for sync
endif

" Set wildmenu
set wildmenu

"""""""""""" SIZE OF VIM """""""""""""""""""""""""""
" size of vim
if has("gui_running")
    set lines=65 columns=200
    set guifont=Monospace\ 12
endif
    set guifont=Monospace\ 14

map <space> :BufExplorer<RETURN>

"""""""""""" ConqueTerm GDB settings """""""""""""""""""""""""""
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly 
let g:ConqueGdb_SaveHistory = 1

"""""""""""" TAG BAR  """""""""""""""""""""""""""
let g:tagbar_left = 0
let g:tagbar_autofocus = 1
let g:tagbar_width = 55

"""""""""""" ASYNCRUN  """""""""""""""""""""""""""
let g:asyncrun_open = 8
let g:asyncrun_save = 1
let g:asyncrun_bell = 1
" Highlight of AsyncRun exit messages
hi AsyncRunFail ctermfg=124 guifg=#942f1f
hi AsyncRunOK ctermfg=LightGreen guifg=#558C00
" Do not silent AsyncRunEvents
let g:asyncrun_silent = 0
" Echo exit status of AsyncRun command
autocmd User AsyncRunStop if g:asyncrun_code != 0 | echohl AsyncRunFail |
			\ echo 'AsyncRun: [FAIL]' |  
			\ else | echohl AsyncRunOK |
			\ echo 'AsyncRun: [OK]' | sleep 2 | cclose | endif | echohl Normal

"""""""""""" ALE  """""""""""""""""""""""""""
let g:ale_linters = {'cpp' : ['gcc'], 'c' : ['gcc']}
let g:ale_completion_enabled = 0
let g:ale_enabled = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1
let g:ale_sign_error='XX'
let g:ale_sign_warning='W'
let g:ale_cursor_detail=0
let g:ale_cache_executable_check_failures = 1
let g:ale_lint_delay = 500
hi ALEErrorSign ctermfg=red ctermbg=none
hi ALEWarningSign ctermfg=yellow ctermbg=none
let g:ale_c_parse_makefile=1
let g:ale_c_build_dir='/home/ppatel/git/example/sapphire/build/debug/'
"highlight link ALEErrorLine error
"highlight link ALEWarningLine warning
let g:ale_cpp_gcc_executable="/usr/bin/g++-7"
let g:ale_cpp_gcc_options = '-isystem /usr/include/c++/7/ -isystem /usr/include -isystem /usr/local/include/ -I/home/ppatel/git/example/sapphire/e7core/ -I/home/ppatel/git/example/sapphire/hawk/ -I/home/ppatel/git/example/sapphire/ -I/home/ppatel/git/example/sapphire/sapphire/ -I/home/ppatel/git/example/sapphire/apps/create_sections/ -I/home/ppatel/git/example/sapphire/apps/log_reader/ -I/home/ppatel/git/example/sapphire/messages/generated/ -I/home/ppatel/git/example/sapphire/messages/generated/Example/ -I/home/ppatel/git/example/sapphire/messages/generated/feeder/ -I/home/ppatel/git/example/sapphire/messages/generated/pricefeeders/ -I/home/ppatel/git/example/sapphire/messages/generated/Sapphire/ -I/home/ppatel/git/example/sapphire/sapphire/ -I/home/ppatel/git/example/sapphire/sapphire/gateways/pricefeed/lib/ -I/home/ppatel/git/example/sapphire/sapphire/nodes/ -I/home/ppatel/git/example/sapphire/sapphire/p2p/ -I/home/ppatel/git/example/sapphire/sapphire/sapphirelibs/ -I/include/ -I/opt/eagleseven/straits/include/ -isystem /usr/local/share/drop/Concord.Risk-1.7/Concord.Risk-1.7.44/ -isystem /usr/local/share/drop/Concord.Storage-1.4/Concord.Storage-1.4.23/ -isystem /usr/local/share/drop/Raptor.Api-3.3/Raptor.Api-3.3.21/ -I/usr/include/postgresql/ -I/usr/include/postgresql/9.5/server/ -I/usr/include/postgresql/9.5/server/ -I/usr/local/share/drop/ -I/usr/local/share/drop/cryptopp-5.6.5/include/ -I/usr/local/share/drop/cuda-9.2/include/ -I/usr/local/share/drop/gtest-1.8/include/ -I/usr/local/share/drop/jgate_omex-2018.05/include/ -I/usr/local/share/drop/Lime.Citrus-2.2/Lime.Citrus-2.2.9/ -I/usr/local/share/drop/openonload/openonload-201710-u1/include/ -I/usr/local/share/drop/taocpp/1.0.0-beta11/include/ -I/usr/local/share/drop/websocketpp/0.6.0.2/include/ -march=haswell -mtune=haswell -mno-avx -mno-avx2 -mpopcnt -msse4.2 -mabm -maes -mbmi -mbmi2 -mcx16 -mf16c -mfma -mfsgsbase -mfxsr -mlzcnt -mmmx -mmovbe -mpclmul -mrdrnd -msahf -mxsaveopt -std=c++17 -ggdb3 -pedantic -Wall -Werror -Wno-comment -Wno-invalid-offsetof -fno-omit-frame-pointer -fno-stack-protector --param=ssp-buffer-size=8 -fno-strict-aliasing -fpermissive -Wl,--copy-dt-needed-entries'
let b:ale_cpp_gcc_options = g:ale_cpp_gcc_options
au BufRead,BufNewFile *.ipp set filetype=cpp
"
"let g:ale_cpp_gcc_options = '-I/home/ppatel/git/example/sapphire/  -I/home/ppatel/git/example/sapphire/apps/create_sections/ -I/home/ppatel/git/example/sapphire/apps/log_reader/ -I/home/ppatel/git/example/sapphire/e7core/ -I/home/ppatel/git/example/sapphire/hawk/ -I/home/ppatel/git/example/sapphire/messages/generated/ -I/home/ppatel/git/example/sapphire/messages/generated/Example/ -I/home/ppatel/git/example/sapphire/messages/generated/feeder/ -I/home/ppatel/git/example/sapphire/messages/generated/pricefeeders/ -I/home/ppatel/git/example/sapphire/messages/generated/Sapphire/ -I/home/ppatel/git/example/sapphire/sapphire/ -I/home/ppatel/git/example/sapphire/sapphire/gateways/pricefeed/lib/ -I/home/ppatel/git/example/sapphire/sapphire/nodes/ -I/home/ppatel/git/example/sapphire/sapphire/p2p/ -I/home/ppatel/git/example/sapphire/sapphire/sapphirelibs/ -I/include/ -I/opt/eagleseven/straits/include/ -isystem /usr/local/share/drop/Concord.Risk-1.7/Concord.Risk-1.7.44/ -isystem /usr/local/share/drop/Concord.Storage-1.4/Concord.Storage-1.4.23/ -isystem /usr/local/share/drop/Raptor.Api-3.3/Raptor.Api-3.3.21/ -I/usr/include/postgresql/ -I/usr/include/postgresql/9.5/server/ -I/usr/include/postgresql/9.5/server/ -I/usr/local/share/drop/ -I/usr/local/share/drop/cryptopp-5.6.5/include/ -I/usr/local/share/drop/cuda-9.2/include/ -I/usr/local/share/drop/gtest-1.8/include/ -I/usr/local/share/drop/jgate_omex-2018.05/include/ -I/usr/local/share/drop/Lime.Citrus-2.2/Lime.Citrus-2.2.9/ -I/usr/local/share/drop/openonload/openonload-201710-u1/include/ -I/usr/local/share/drop/taocpp/1.0.0-beta11/include/ -I/usr/local/share/drop/websocketpp/0.6.0.2/include/ -march=haswell -mtune=haswell -mno-avx -mno-avx2 -mpopcnt -msse4.2 -mabm -maes -mbmi -mbmi2 -mcx16 -mf16c -mfma -mfsgsbase -mfxsr -mlzcnt -mmmx -mmovbe -mpclmul -mrdrnd -msahf -mxsaveopt -std=c++17 -ggdb3 -pedantic -Wall -Werror -Wno-comment -Wno-invalid-offsetof -fno-omit-frame-pointer -fno-stack-protector --param=ssp-buffer-size=8 -fno-strict-aliasing -Wl,--copy-dt-needed-entries'
"let g:ale_echo_cursor = 1
"let g:ale_echo_msg_error_str = 'Error'
"let g:ale_echo_msg_format = '%s'
"let g:ale_echo_msg_warning_str = 'Warning'
"let g:ale_keep_list_window_open = 0
"let g:ale_lint_delay = 1
"let g:ale_linter_aliases = {}
"let g:ale_open_list = 0
"let g:ale_set_highlights = 1
"let g:ale_set_loclist = 1
"let g:ale_set_quickfix = 0
"let g:ale_sign_column_always = 0
"let g:ale_sign_offset = 1000000
"let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
"let g:ale_warn_about_trailing_blank_lines = 0
"let g:ale_warn_about_trailing_whitespace = 1
"let g:ale_cpp_gcc_executable="/usr/bin/g++-7"
"let g:ale_cpp_clang_options = '-Wall -I.  -I/home/ppatel/git/example/sapphire/.  -I/home/ppatel/git/example/sapphire/apps/create_sections -I/home/ppatel/git/example/sapphire/apps/log_reader -I/home/ppatel/git/example/sapphire/e7core -I/home/ppatel/git/example/sapphire/hawk -I/home/ppatel/git/example/sapphire/hawk/.  -I/home/ppatel/git/example/sapphire/messages/generated -I/home/ppatel/git/example/sapphire/messages/generated/Example -I/home/ppatel/git/example/sapphire/messages/generated/feeder -I/home/ppatel/git/example/sapphire/messages/generated/pricefeeders -I/home/ppatel/git/example/sapphire/messages/generated/Sapphire -I/home/ppatel/git/example/sapphire/sapphire -I/home/ppatel/git/example/sapphire/sapphire/gateways/pricefeed/lib -I/home/ppatel/git/example/sapphire/sapphire/nodes -I/home/ppatel/git/example/sapphire/sapphire/p2p/.  -I/home/ppatel/git/example/sapphire/sapphire/sapphirelibs -I/include -I/opt/eagleseven/straits/include -isystem /usr/local/share/drop/Concord.Risk-1.7/Concord.Risk-1.7.44 -isystem /usr/local/share/drop/Concord.Storage-1.4/Concord.Storage-1.4.23 -isystem /usr/local/share/drop/Raptor.Api-3.3/Raptor.Api-3.3.21 -I/usr/include/postgresql -I/usr/include/postgresql/9.5/server -I/usr/include/postgresql/9.5/server -I/usr/local/share/drop -I/usr/local/share/drop/cryptopp-5.6.5/include -I/usr/local/share/drop/cuda-9.2/include -I/usr/local/share/drop/gtest-1.8/include -I/usr/local/share/drop/jgate_omex-2018.05/include -I/usr/local/share/drop/Lime.Citrus-2.2/Lime.Citrus-2.2.9 -I/usr/local/share/drop/openonload/openonload-201710-u1/include -I/usr/local/share/drop/taocpp/1.0.0-beta11/include -I/usr/local/share/drop/websocketpp/0.6.0.2/include -march=haswell -mtune=haswell -mno-avx -mno-avx2 -mpopcnt -msse4.2 -mabm -maes -mbmi -mbmi2 -mcx16 -mf16c -mfma -mfsgsbase -mfxsr -mlzcnt -mmmx -mmovbe -mpclmul -mrdrnd -msahf -mxsaveopt -std=c++17 -ggdb3 -pedantic -Wall -Werror -Wno-comment -Wno-invalid-offsetof -fno-omit-frame-pointer -fno-stack-protector --param=ssp-buffer-size=8 -fno-strict-aliasing -Wl,--copy-dt-needed-entries'

""""""" You complete me """" 
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_error_symbol='YE'
let g:ycm_warning_symbol='YW'
let g:ycm_max_diagnostics_to_display = 1000
let g:ycm_confirm_extra_conf=0
let g:ycm_log_level = 'debug'
set completefunc=youcompleteme#OmniComplete
set omnifunc=youcompleteme#OmniComplete
map <Leader>f :YcmCompleter GoTo<CR>
map <Leader>ff :YcmCompleter FixIt<CR>

au BufRead,BufNewFile *.ipp set filetype=cpp

"nnoremap <C-down> <C-O>
"let g:ycm_semantic_triggers =  {
"  \   'c' : ['->', '.','re![_a-zA-z0-9]'],
"  \   'cpp,objcpp' : ['->', '.', '::','re![_a-zA-Z0-9]'],
"  \ }
"let g:ycm__extra_conf='/home/ppatel/git/example/sapphire/.ycm_extra_conf.py'
"let g:ycm_cache_omnifunc=1
"let g:ycm_seed_identifiers_with_syntax=1

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
nmap <F9> :AsyncRun ~/bin/buildApp.sh btec_drop<cr>
nmap <F10> :cclose <cr>
nmap <F11> :call BuildDbg()<cr>
function! BuildDbg()
    cd /home/ppatel/git/example/sapphire/build/debug/
    "set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ cmerouter-test
    set makeprg=make\ -j3\ VERBOSE=1\ debug=1\ btec_drop
    make | copen | resize 25
endfunction
nmap <F12> :ALEDetail <cr>

""""""""""""  a.vim """""""""""""""""""""
nmap <C-i> :A <cr>
nmap <C-]> :exe ":tj /" . expand("<cword>")<CR>
nmap <C-c> :qa <cr>

"""""""""""""""""""""""""" EXPERIMENTAL  """""""""""""""""

"""""""""""" Syntastic  """""""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs=1
"noremap <F10> :execute "copen \| resize 30"<cr>
"noremap <F11>  :execute "vertical botright copen \| vertical resize 188"<cr>
"
" =========== OMNI COMPLETE FEATURES =================== "
" configure tags - add additional tags here or comment out not-used ones
" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"" OmniCppComplete
"PHP let OmniCpp_GlobalScopeSearch   = 1
"PHP let OmniCpp_NamespaceSearch = 1
"PHP let OmniCpp_ShowAccess          = 1 "show access in pop-up
"PHP let OmniCpp_DisplayMode         = 1
"PHP let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
"PHP let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
"PHP let OmniCpp_SelectFirstItem     = 1 "select first item in pop-up
"PHP let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"PHP let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"PHP let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"PHP let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "_GLIBCXX_STD_A", "_GLIBCXX_STD_C"]
"PHP au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"PHP set completeopt=menuone,menu,longest,preview

" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q -I _GLIBCXX_NOEXCEPT .<CR>

"============= Clang Complete ======================="
"let g:clang_library_path='/home/ppatel/bin/CLANG/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04/lib/libclang.so'
"set completefunc=ClangComplete
"set omnifunc=ClangComplete

"============= Compile directly off vim ======================="
"super tab plugin
"let g:SuperTabDefaultCompletionType = "context"

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"PHP let g:UltiSnipsExpandTrigger="<tab>"
"PHP let g:UltiSnipsJumpForwardTrigger="<c-b>"
"PHP let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"PHP " If you want :UltiSnipsEdit to split your window.
"PHP let g:UltiSnipsEditSplit="vertical"

"=============Unneeded plugin======================="
"Bundle 'kshenoy/vim-signature'
"Bundle 'vim-scripts/OmniCppComplete'
"Bundle 'wincent/command-t'
"Bundle 'ervandew/supertab'
"Bundle 'vim-scripts/Conque-GDB'
"Bundle 'LucHermitte/lh-vim-lib'
"Bundle 'LucHermitte/lh-style'
"Bundle 'LucHermitte/lh-tags'
"Bundle 'LucHermitte/lh-dev'
"Bundle 'LucHermitte/lh-brackets'
"Bundle 'LucHermitte/searchInRuntime'
"Bundle 'LucHermitte/mu-template'
"Bundle 'tomtom/stakeholders_vim'
"Bundle 'LucHermitte/alternate-lite'
"Bundle 'LucHermitte/lh-cpp'
"Bundle 'ctrlp.vim'
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
"Bundle 'matchit.zip'
"Bundle 'vim-scripts/a.vim'
"Bundle 'richq/cmake-lint'
"Bundle 'mrtazz/checkmake'
"Bundle 'vim-scripts/taglist.vim'
"Bundle 'vim-syntastic/syntastic'
"Bundle 'rickhowe/diffchar.vim'
"Bundle 'mileszs/ack.vim'
