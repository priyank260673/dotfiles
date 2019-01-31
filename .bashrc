# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias v='vim'
alias g++='/usr/bin/g++-7'

# Tmux aliases
alias tmn='tmux -2 new -s $1'
alias tml='tmux ls'
alias tmr='tmux attach -d -t $1'
alias tmk='tmux kill-session -t $1'
alias tmd='tmux detach'
alias st='tmux rename-window $1'
alias tl='tmux last-window'

alias sn='screen -S $1'
alias sr='screen -d -r $1'
alias sl='screen -ls'
alias sd='screen -d $1'
alias st='~/bin/scrnTitle.sh'

# Set aliases
alias btags='~/bin/buildTags.sh'
alias tf='tail -f '
alias s='source ~/.bashrc'

set -o vi

# Set editor for SVN
export EDITOR=vim

# set core limit unlimited
ulimit -c unlimited 

# functions
function dtoh() {
    printf "%X\n" $1
}

function htod() {
    printf "%d\n" $1
}

function grpLoadAll() {
    vim `grep -ilR $1 *`
}

function grpLoadInFile() {
   vim `find . -name $1 | xargs grep -l $2`
}


function vf {
     vim `find . -iname $1`
}

function gvf {
    vim `find . -iname $1`
}

function ff {
     find `pwd` -iname $1
}

function cdf {
 local cmd="find `pwd` -iname $1"
 local fullPath=`eval $cmd`
 local getPath=${fullPath%/*};
 cd $getPath
}

function tag {
    vim -t $1
}

function st {
    changeTitle.sh $1
}

function qcg { 
    ~/bin/qcachegrind -c $1
}

function mgrind {
    valgrind --tool=memcheck --leak-check=full --track-origins=yes --show-reachable=yes --demangle=yes --log-file=./memcheck.txt --num-callers=20 $@
}

function cgrind {
    valgrind --tool=callgrind  --demangle=yes --num-callers=20 --separate-threads=yes  --dump-instr=yes $@
}

function cgrindnost {
    valgrind --tool=callgrind  --demangle=yes --num-callers=20 --separate-threads=no  --dump-instr=yes $@
}

function hgrind {
    valgrind --tool=helgrind  --read-var-info=yes --demangle=yes --num-callers=20 $@
}

function list_tests()
{
   $1 --gtest_list_tests
}

function run_test()
{
   echo "Running test $1 --gtest_filter=$2"
   $1 --gtest_filter=$2
}

alias gobld='cd /home/ppatel/git/example/sapphire/build/debug/'
function blddv {
   export E7_BUILD_TYPE=Debug
   mkdir -p /home/ppatel/git/example/sapphire/build/debug/
   cd /home/ppatel/git/example/sapphire/build/debug/
   cmake --verbose --trace ../.. &> /home/ppatel/git/example/sapphire/build/debug/cmake_out.txt
   make -j2 VERBOSE=1 -f CMakeFiles/Makefile2  &> /home/ppatel/git/example/sapphire/build/debug/build_out_verbose.txt
}

function bldd {
   export E7_BUILD_TYPE=Debug
   mkdir -p /home/ppatel/git/example/sapphire/build/debug/
   cd /home/ppatel/git/example/sapphire/build/debug/
   cmake ../.. &> /home/ppatel/git/example/sapphire/build/debug/cmake_out.txt
   make -j3 -f CMakeFiles/Makefile2  &> /home/ppatel/git/example/sapphire/build/debug/build_out.txt
}

alias gobldr='cd /home/ppatel/git/example/sapphire/build/release/'
function bldr {
   export E7_BUILD_TYPE=Release
   mkdir -p /home/ppatel/git/example/sapphire/build/release/
   cd /home/ppatel/git/example/sapphire/build/release/
   cmake --verbose --trace .. &> /home/ppatel/git/example/sapphire/build/release/cmake_out.txt
   make -j3 VERBOSE=1 -f CMakeFiles/Makefile2  &>> /home/ppatel/git/example/sapphire/build/release/build_out.txt
}

function build {
	cd /home/ppatel/git/example/sapphire/build/debug/
	make -j3 CMakeFiles/Makefile2 $1
}

export E7_ARCH=haswell
export PATH=~/bin/CTAGS/LATEST/ctags:/home/ppatel/bin/GDB/gdb-8.2.1/gdb:${PATH}:.
#export PATH=~/bin/CTAGS/LATEST/ctags:${PATH}:.:/home/ppatel/bin/CLANG/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/
export CSCOPE_DB=/home/ppatel/tags/cscsope.out

##----------------------------- ## 
alias gitd='git d'
alias gitsubpullmast='git submodule foreach git pull origin master'
alias gitsubcheckoutmast='git submodule foreach git checkout master'
alias gitdiff_f='git diff --name-only'
alias dffos='git d /home/ppatel/git/example/sapphire/sapphire/'
alias dffm='git d master .'
##----------------------------- ## 

alias gosaph='cd /home/ppatel/git/example/sapphire/sapphire'
alias gorouter='cd /home/ppatel/git/example/sapphire/sapphire/gateways/router'
alias tbd='tail -f /home/ppatel/git/example/sapphire/debug/build_debug_allout.txt'

#alias gdb='/home/ppatel/bin/GDB/gdb-8.2.1/gdb/gdb --data-directory=/home/ppatel/bin/GDB/gdb-8.2.1/gdb/data-directory'
export TERM=xterm-256color

function debug {
    emacs --eval "(gdb \"gdb -i=mi ; --args $* \")";
}

function debugnw {
    emacs -nw --eval "(gdb \"gdb -i=mi ; --args $* \")";
}

