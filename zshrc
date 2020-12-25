
fpath=($fpath ~/.zsh.d/anyframe(N-/))

# load zinit
# ==============================

source ~/.zinit/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-git-prompt/zsh-git-prompt
zinit load zdharma/history-search-multi-word
zinit load 39e/zsh-completions-anyenv
zinit light mollifier/anyframe

zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

zinit wait lucid atload"zicompinit; zicdreplay" blockf for zsh-users/zsh-completions

# load alias, environment variable, and so on
# ==========================================

source ~/.shrc.share

# 環境依存設定
# ================================================

# 重複したパスを削除
typeset -U path PATH
typeset -U fpath FPATH

# プログラムパス
path=(
  ${path}
)


# 関数群の追加
fpath+=(~/.zsh.d)
autoload -U dl


# プロンプト関係
# ================================================

# プロンプトに escape sequence (環境変数) を通す
setopt prompt_subst

# ^[  は「エスケープ」
# \e[31m，\e[mとかは，それぞれ%{%}でくくってあげないと，補完時に位置ズレする
# まとめてくくろうとかは不可

# 通常のプロンプト
PROMPT="%B%{[1;31m%}%n@%m%{[m%}(%{[1;34m%}%c%{[m%})"$'\n'"$sprompt%B%{[1;31m%}%#%{[m%}%b "

# forやwhile/複数行入力時などに表示されるプロンプト
PROMPT2="%B%_>%b "

# set -x時に利用されるプロンプト
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
#PROMPT4="+%N:%i>"
PROMPT4="%B%F{yellow}%N:%i%f>%b "

# 入力ミスを確認する場合に表示されるプロンプト
SPROMPT="%r is correct? [n,y,a,e]: "

# 右に表示したいプロンプト(24時間制での現在時刻)
#RPROMPT="%T"

# 右プロンプトに入力がきたら消す
setopt transient_rprompt

# ターミナルのタイトル
case "${TERM}" in
    kterm*|xterm*|cygwin)
	precmd() {
        #echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        #echo -ne "\033]0;${PWD}\007"
        #print -Pn "\e]0;%n@%m: %~\a"
        #print -Pn "\e]0;%~\a"
        print -Pn "\e]0;${PWD/${PWD%*\/*\/*}\/}\a"
	}
	;;
esac


# エイリアスの設定
# ================================================


# 補完される前にオリジナルのコマンドまで展開してチェックする
setopt complete_aliases

# 履歴関係
# ================================================

# ヒストリー機能
HISTFILE=/tmp/$USER.zsh_history      # ヒストリファイルを指定
HISTSIZE=1000000             # ヒストリに保存するコマンド数
SAVEHIST=1000000             # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history        # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
#setopt inc_append_history   # 履歴をインクリメンタル(コマンド実行毎)に追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録

# cd - と入力してTabキーで今までに移動したディレクトリを一覧表示
setopt auto_pushd

# ディレクトリスタックに重複する物は古い方を削除
setopt pushd_ignore_dups

# コマンド履歴の検索機能の設定
# ^[  は「エスケープ」
# viなら    Ctrl-v ESC
# Emacsなら Ctrl-q ESC
# viで編集する場合
# 上2行は Ctrl-v を押下した後、希望のキーを押下
# 下2行は「エスケープ」の後にキーの端末コードを入力
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "[A" history-beginning-search-backward-end
bindkey "[B" history-beginning-search-forward-end

# 複数行コマンドの場合、上記の設定だと少々不都合
# tcshの様にする場合は以下のようにする
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# インクリメンタルサーチの設定
#bindkey "^R" history-incremental-search-backward
#bindkey "^S" history-incremental-search-forward

#bindkey ${$(echotc bt 2>&-):-"[Z"} reverse-menu-complete
#bindkey "#setopt menu_complete

bindkey "[Z" reverse-menu-complete

# 全履歴の一覧を出力する
function history-all { history -E 1 }


# キーバインド
# ================================================

# viライクキーバインド
#bindkey -v
# Emacsライクキーバインド
#bindkey -e

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xp' anyframe-widget-cd-git-worktree
bindkey '^x^p' anyframe-widget-cd-git-worktree

#BackSpaceキーの割り当て(端末によって設定が違う)
#console setting
#bindkey "^?" backward-delete-char
#bindkey "^H" backward-delete-char
#bindkey ${$(echotc bt 2>&-):-"[Z"} reverse-menu-complete

#DEL,HIME,ENDキーの割り当て
#bindkey "[3~" delete-char
#bindkey "[1~" beginning-of-line
#bindkey "[4~" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "[3~" delete-char

#solaris
if [ "$HOST" = "rhine" -o "$HOST" = "shinano" ]; then
    bindkey "[3~" delete-char
    bindkey "<Home>" beginning-of-line
    bindkey "[4~" end-of-line
fi

#x setting also console
#bindkey "^?" delete-char
#bindkey "^H" backward-delete-char
#bindkey "[3~" delete-char

# Ctrl+矢印キーで単語移動
bindkey ";5C" forward-word
bindkey ";5D" backward-word


# 補完機能
# ================================================

# 補完機能を有効にする
autoload -Uz compinit

autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Cygwinのときは-uオプションをつける
# zcompdumpファイルの格納パスを変更
compinit -u -d /tmp/$USER.zcompdump

alias fig='docker-compose'
compdef fig=docker-compose

# ディレクトリ名を入力するだけでカレントディレクトリを変更
setopt auto_cd

# タブキー連打で補完候補を順に表示
setopt auto_menu

# 自動修正機能(候補を表示)
#setopt correct

# カレントディレクトリを意味する最初のドットを要求しない(rm .* 対策)
setopt glob_dots

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# パスの最後に付くスラッシュを自動的に削除しない
setopt noautoremoveslash

# = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt magic_equal_subst

# 補完候補リストの日本語を正しく表示
setopt print_eight_bit

# 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補にも色付き表示
#eval `dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'


# その他
# ================================================

# ファイル作成時のパーミッション
umask 022

setopt no_beep               # ビープ音を消す
setopt nolistbeep            # 補完候補表示時などにビープ音を鳴らさない
#setopt interactive_comments  # コマンドラインで # 以降をコメントとする
setopt numeric_glob_sort     # 辞書順ではなく数値順でソート
setopt no_multios            # zshのリダイレクト機能を制限する
unsetopt promptcr            # 改行コードで終らない出力もちゃんと出力する
setopt ignore_eof            # Ctrl-dでログアウトしない
#setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
#setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる
#setopt rm_star_wait          # rm * を実行する前に確認
#setopt rm_star_silent        # rm * を実行する前に確認しない
#setopt no_clobber            # リダイレクトで上書きを禁止
unsetopt no_clobber          # リダイレクトで上書きを許可
#setopt chase_links           # シンボリックリンクはリンク先のパスに変換してから実行
#setopt print_exit_value      # 戻り値が 0 以外の場合終了コードを表示
#setopt single_line_zle       # デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
setopt interactivecomments    # コマンド行でもコメント機能を有効にする

# カーソル位置から前方削除(Ctrl-u)
#bindkey '^U' backward-kill-line

# Ctrl-h(backspace) で単語ごとに削除
#bindkey "^h" backward-kill-word

# 単語の一部とみなさない記号
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>/'



# 参考
# http://www.crimson-snow.net/tips/unix/zsh.html
# http://cvs.sourceforge.jp/cgi-bin/viewcvs.cgi/linuxtips/memo/zsh.txt?rev=1.1.1.1

if [ -e ~/.sh.d/gwt.sh ]; then
    source ~/.sh.d/gwt.sh
    zle -N gwt-cd
    bindkey '^]p' gwt-cd
    zle -N gwt-ghq
    bindkey '^]g' gwt-ghq
fi

[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local


# プロンプト設定
ZSH_GIT_PROMPT_PYBIN=/usr/bin/python3
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX=" ]"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{ %G%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[magenta]%}%{x%G%}"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}%{-%G%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}%{+%G%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"
PROMPT="%B%{[1;31m%}%n@%m%{[m%}(%{[1;34m%}%c%{[m%})"'$(git_super_status)'$'\n'"$sprompt%B%{[1;31m%}%#%{[m%}%b "


