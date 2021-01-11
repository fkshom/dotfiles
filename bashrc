
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ignorespace+ignoredups　空白文字で始まる行を保存しない、以前の履歴と一致する行を保存しない
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# ヒストリファイルの最大値 -1:無限
HISTFILESIZE=-1

# ヒストリファイルの保存するコマンド数
HISTSIZE=-1

# historyコマンドの出力フォーマット
HISTTIMEFORMAT='%F %T '

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
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

for bcfile in ~/.local/share/bash-completions/* ; do
  [ -f "$bcfile" ] && . $bcfile
done

# 複数行コマンドを単一エントリとして保存する
shopt -s cmdhist

# セミコロン区切り記号ではなく改行による複数行コマンドを履歴に保存する
shopt -s lithist

# ヒストリファイルに追記する
shopt -s histappend

# 履歴置換を再編集する機会を得る
shopt -s histreedit

# 履歴置換の結果を編集バッファにロードし編集を可能とする
shopt -s histverify


peco_search_history() {
    local l=$(HISTTIMEFORMAT= history | \
                  sed -e 's/^[0-9\| ]\+//' -e 's/ \+$//' | \
                  tac | uniq | \
                  peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
if type peco >/dev/null 2>&1; then
  bind -x '"\C-r": peco_search_history'
fi

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}
function promps {
    local  BLUE="\[\e[1;34m\]"
    local  RED="\[\e[1;31m\]"
    local  GREEN="\[\e[1;32m\]"
    local  WHITE="\[\e[00m\]"
    local  GRAY="\[\e[1;37m\]"

    case $TERM in
        xterm*) TITLEBAR='\[\e]0;\W\007\]';;
        *)      TITLEBAR="";;
    esac
    local BASE="\u@\h"
    PS1="${TITLEBAR}${GREEN}${BASE}${WHITE}(${BLUE}\W${WHITE})${GREEN}\$(parse_git_branch)${BLUE}\n\$${WHITE} "
}
promps

if [ -f ~/.sh.d/gwt.sh ]; then
    source ~/.sh.d/gwt.sh
    bind -r "\C-]"
    bind -x '"\C-]p":gwt-cd'
    bind -x '"\C-]g":gwt-ghq'
fi

if [ -d ~/.bash.d/anyframe ]; then
    source ~/.bash.d/anyframe
    bind -x '"\C-x\C-g": anyframe-widget-cd-git-worktree'
fi

[ -f ~/.shrc.share ] && source ~/.shrc.share
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

complete -C '/usr/local/bin/aws_completer' aws
