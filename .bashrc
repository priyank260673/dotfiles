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

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
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
alias pegi='ps -eaf | grep -i $1'
alias nnta='netstat -nta | grep -i $1'

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
alias vimf='vim `find . -type f`'

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

function dtob() {
	echo "obase=2;$1" | bc
}

function htob() {
    local htod1="printf "%d" $1"
	local htod2=`eval $htod1`
	echo $htod2
	echo "obase=2;$htod2" | bc
}

function btod() {
	echo "$((2#$1))"
}

function vimg() {
    vim `egrep -lR $* * | grep -v unit-test`
}

function vimga() {
    vim `grep -lR $* *`
}

function vimgi() {
    vim `egrep -ilR $* * | grep -v unit-test`
}

function vimgui() {
    vim `grep -ilR $* *`
}

function vims() {
	vim `git status -s -uno | cut -c4-`
}

function vimgdiff() {
	cd ~/git/example/sapphire/sapphire/
    vim `git diff --name-only $1`
}

function grpLoadInFile() {
   vim `find . -name $* | xargs grep -l $2`
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

function vimall {
	vim `find . -not -path '*/\.*' -type f | egrep "\.h|\.hpp|\.cpp|\.ipp" | grep -v unit-test | grep -v build`
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

export E7_BUILD_TYPE=Debug

alias gobld='cd /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell'
function blddv {
   export E7_BUILD_TYPE=Debug
   mkdir -p /home/ppatel/git/example/sapphire/build/
   cd /home/ppatel/git/example/sapphire/
   /opt/eagleseven/build/scripts/e7_cmake.sh
   cd /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/
   cmake --verbose --trace ../.. &> /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/cmake_out.txt
   make -j2 VERBOSE=1 -f CMakeFiles/Makefile2  &> /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/build_out_verbose.txt
}

function bldd {
   export E7_BUILD_TYPE=Debug
   mkdir -p /home/ppatel/git/example/sapphire/build/
   cd /home/ppatel/git/example/sapphire/
   /opt/eagleseven/build/scripts/e7_cmake.sh
   cd /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/
   cmake --verbose --trace ../.. &> /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/cmake_out.txt
   make -j3 -f CMakeFiles/Makefile2  &> /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/build_out_verbose.txt
}

alias gobldr='cd /home/ppatel/git/example/sapphire/build/'
function bldr {
   export E7_BUILD_TYPE=Release
   mkdir -p /home/ppatel/git/example/sapphire/build/
   cd /home/ppatel/git/example/sapphire/
   /opt/eagleseven/build/scripts/e7_cmake.sh
   cd /home/ppatel/git/example/sapphire/build/Release-g++-8-haswell/
   cmake ../.. &> /home/ppatel/git/example/sapphire/build/Release-g++-8-haswell/cmake_out.txt
   make -j3 -f CMakeFiles/Makefile2  &> /home/ppatel/git/example/sapphire/build/Release-g++-8-haswell/build_out_verbose.txt
}

function build {
	cd /home/ppatel/git/example/sapphire/build/debug/
	make -j3 CMakeFiles/Makefile2 $1
}

export E7_ARCH=haswell
#export PATH=/home/ppatel/TOOLS/GDB/gdb-8.3.1/gdb/:${PATH}:.:/home/ppatel/TOOLS/CLANG/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/:
export PATH=~/extra_git/ctags/:/home/ppatel/TOOLS/GDB/gdb-8.3.1/gdb/:${PATH}:.:/home/ppatel/TOOLS/CLANG/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/:
export CSCOPE_DB=/home/ppatel/tags/cscsope.out
export MAN_DISABLE_SECCOMP=1

##----------------------------- ## 
alias gitd='git d HEAD'
alias gitsubpullmast='git submodule foreach git pull origin master'
alias gitsubcheckoutmast='git submodule foreach git checkout master'
alias gitdiff_f='git diff --name-only $1'
alias dffos='git d /home/ppatel/git/example/sapphire/sapphire/'
alias dffm='git d master .'
##----------------------------- ## 

alias gosaph='cd /home/ppatel/git/example/sapphire/sapphire'
alias gorouter='cd /home/ppatel/git/example/sapphire/sapphire/gateways/router'
alias tbd='tail -f /home/ppatel/git/example/sapphire/debug/build_debug_allout.txt'
alias goqaextra='ssh -YC ch0qslss001 -l faction\\qa'
alias goqa1='ssh -YC ch0dslqa001 -l faction\\qa'
alias goqa2='ssh -YC ch0dslqa002 -l faction\\qa'
alias goqa3='ssh -YC ch0dslqa003 -l faction\\qa'
alias goqa4='ssh -YC ch0dslqa004 -l faction\\qa'
alias goqa5='ssh -YC ch0dslqa005 -l faction\\qa'
#alias gograntqa='ssh -YC ch1qwwqa001 -l faction\\qa'
#alias gorickqa='ssh -YC ch1qwwqa002 -l faction\\qa'

alias goperf6='ssh -YC ch1dslpf006 -l ppatel'
alias goperf4='ssh -YC ch1dslpf004 -l ppatel'
#alias gdb='/home/ppatel/bin/GDB/gdb-8.2.1/gdb/gdb --data-directory=/home/ppatel/bin/GDB/gdb-8.2.1/gdb/data-directory'
export TERM=xterm-256color
alias gohawk_eurex='cd /home/ppatel/git/example/sapphire/hawk/hawk/feeder/exchanges/eurex/eobi/'
alias gofeeder_eurex='cd /home/ppatel/git/example/sapphire/sapphire/gateways/feeder/eurex/'

function debugnw {
    emacs --eval "(gdb \"gdb -i=mi ; --args $* \")";
}

function debug {
    emacs -nw --eval "(gdb \"gdb -i=mi ; --args $* \")";
}

# Display branch working on path
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h:\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

function display_assem() {
	g++ $1 -O2 -c -S -o - -masm=intel | c++filt | grep -vE '\s+\.' 
}

function gcheckout() 
{
	cd /home/ppatel/git/example/sapphire/
	git checkout master; git pull; git checkout $1; git pull
	cd sapphire; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd hawk; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd e7core; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd messages; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd sapphire
}

function gcheckoutrelnrc() 
{
	cd /home/ppatel/git/release_nrc_repo/example/sapphire/
	git checkout master; git pull; git checkout $1; git pull
	cd sapphire; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd hawk; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd e7core; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd messages; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd sapphire
}

function gcheckoutmaster() 
{
	cd /home/ppatel/git/master_repo/example/sapphire/
	git checkout master; git pull; git checkout $1; git pull
	cd sapphire; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd hawk; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd e7core; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd messages; git checkout master; git pull; git checkout $1; git pull; cd ..
	cd sapphire
}

function grevert() 
{
	git checkout $1
}

alias remote='git config --get remote.origin.url'

# FZF setup
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#export FZF_DEFAULT_COMMAND='(find /home/ppatel/git/example/sapphire/ -path "*/\.*" -prune -o -type f -print -o -type l -print | grep -v build )2> /dev/null'

#export FZF_DEFAULT_COMMAND='
#  (git ls-tree -r --name-only HEAD ||
#   find /home/ppatel/git/example/sapphire/sapphire/ /home/ppatel/git/example/sapphire/e7core /home/ppatel/git/example/sapphire/hawk /home/ppatel/git/example/sapphire/messages/ -path "*/\.*" -prune -o -type f -print -o -type l -print |
#      sed s/^..//) 2> /dev/null'
#export FZF_DEFAULT_COMMAND='(find /home/ppatel/git/example/sapphire/ -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

alias cpy='~/bin/cleanpycores.sh'

alias jasonMachine='ssh -YC ch0dsldv104'

export DBG_DIR='/home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/bin/'
export REL_DIR='/home/ppatel/git/example/sapphire/build/Release-g++-8-haswell/bin/'
export SAN_DIR='/home/ppatel/git/example/sapphire/build/Sanitize-g++-8-haswell/bin/'
export PROFILE_DIR='/home/ppatel/git/example/sapphire/build/Profile-g++-8-haswell/bin/'

export DBG_MASTER_DIR='/home/ppatel/git/master_repo/example/sapphire/build/Debug-g++-8-haswell/bin/'
export REL_MASTER_DIR='/home/ppatel/git/master_repo/example/sapphire/build/Release-g++-8-haswell/bin/'
export SAN_MASTER_DIR='/home/ppatel/git/master_repo/example/sapphire/build/Sanitize-g++-8-haswell/bin/'
export PROFILE_MASTER_DIR='/home/ppatel/git/master_repo/example/sapphire/build/Profile-g++-8-haswell/bin/'

export DBG_RELNRC_DIR='/home/ppatel/git/release_nrc_repo/example/sapphire/build/Debug-g++-8-haswell/bin/'
export REL_RELNRC_DIR='/home/ppatel/git/release_nrc_repo/example/sapphire/build/Release-g++-8-haswell/bin/'
export SAN_RELNRC_DIR='/home/ppatel/git/release_nrc_repo/example/sapphire/build/Sanitize-g++-8-haswell/bin/'
export PROFILE_RELNRC_DIR='/home/ppatel/git/release_nrc_repo/example/sapphire/build/Profile-g++-8-haswell/bin/'

export QA_MACHINE=172.16.0.42
alias gomasterrepo='cd /home/ppatel/git/master_repo/example/sapphire/sapphire/'
alias godevrepo='cd /home/ppatel/git/dev_work/example/sapphire/sapphire/'
alias gorelnrcrepo='cd /home/ppatel/git/release_nrc_repo/example/sapphire/'
alias goglass='cd /mnt/ppatel/GLASS'

alias gomyvm='ssh -YC ppatel@ch0dsldv035'

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib/

alias gohw40='ssh -YC ppatel@172.16.0.40'
alias gohw41='ssh -YC ppatel@172.16.0.41'
alias gohw38='ssh -YC ppatel@172.16.0.38'
#alias gohw10='ssh -YC ppatel@ch1dslhw010'
alias gohw2='ssh -YC FACTION\\ppatel@ch1qslhw002.qa1.local'
alias gohw2_qa='ssh -YC FACTION\\ppatel@ch1dslhw002.qa1.local'
alias go_8='ssh -YC ppatel@ch1dslpf008'
alias gohw1='ssh -YC ppatel@ch1dslhw001'
alias gohw4='ssh -YC ppatel@ch1dslhw004'
alias gohw3='ssh -YC ppatel@ch1dslhw003'
alias gocapture='ssh -YC ppatel@ch1dslss066'
alias topTen='ls -laShR'
alias viml='vim --noplugin $1'
alias copyFromMaster='cp /home/ppatel/git/master_repo/example/sapphire/build/Debug-g++-8-haswell/bin/*_d /home/ppatel/git/example/sapphire/build/Debug-g++-8-haswell/bin/'
export SAPPHIRE_PCAP_PATH=/mnt/intraday_pcaps/
alias notes='vim ~/extra_git/mydotfiles/dotfiles/TechNotes.txt'
export MANPAGER="vim -M +MANPAGER --not-a-term -"
alias checkICC='systemctl status icecc_no_remote.service'
