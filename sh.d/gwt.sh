#!/usr/bin/env bash

GWT_DIR=${GWT_DIR:-~/.git-worktrees/}
GWT_REPOS_DIR=${GWT_REPOS_DIR:-~/.ghq/}

function set-filter() {
  previewer="cat"
  if type "batcat" >/dev/null 2>&1; then
    previewer='batcat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*'
  fi
  filters="fzf-tmux:fzf:peco:percol:gof"
  while [[ -n $filters ]]; do
    filter=${filters%%:*}
    if type "$filter" >/dev/null 2>&1; then
      [[ "$filter" = "fzf" ]] \
        && filter=($filter --preview "$previewer") \
        && multi_filter=($filter --multi --ansi --prompt="gwt >")
      [[ "$filter" = "fzf-tmux" ]] \
        && filter=($filter --preview "$previewer") \
        && multi_filter=($filter --multi --ansi --prompt="gwt >")
      #[[ "$filter" = "fzf" ]] && filter=($filter --ansi --prompt="gwt >") && multi_filter=($filter --multi --ansi --prompt="gwt >")
      #[[ "$filter" = "fzf-tmux" ]] && filter=($filter -r --ansi --prompt="gwt >") && multi_filter=($filter --multi --ansi --prompt="gwt >")
      return 0
    else
      filters="${filters#*:}"
    fi
  done
  echo "gwt: gwt requires fuzzy finder. Either of these is necessary." 1>&2
  echo "fzf, fzf-tmux, peco, percol, gof" 1>&2
  exit 1
}

gwt-checkout(){
  commit_ish=$1
  branchname=${commit_ish##*/}
  path=$GWT_DIR/$branchname

  git worktree add $path $commit_ish
  #git worktree add -B $branchname $path $commit_ish
}
peco-gwt-checkout(){
  echo unko
  local l=$(git branch -a | grep -v -e '->' | cut -b 3- | peco | sed -e "s%remotes/origin/%%")
  if [ -n "$l" ]; then
    branchname=${l##*/}
    cmd="git worktree add -f $GWT_DIR/$branchname $l"
    READLINE_LINE=$cmd
    READLINE_POINT=${#cmd}
  fi
}
#bind -x '"\C-/": peco-gwt-checkout'

gwt-list(){
  :
}
gwt-remove(){
  :
}

_gwt-list-repos(){
  for dir in `find $GWT_REPOS_DIR -maxdepth 5`; do
    if git --git-dir $dir rev-parse --is-inside-git-dir >/dev/null 2>&1;  then
      echo $dir
      worktrees+=("$(git --git-dir $dir worktree list )")
    fi
  done
}

peco-gwt-cd(){
  worktrees=()
  for dir in `_gwt-list-repos`; do
    worktrees+=("$(git --git-dir $dir worktree list )")
  done
  local l=$(printf '%s\n' "${worktrees[@]}" | peco --query "$READLINE_LINE")
  if [ -n "$l" ]; then
    cmd="cd $(echo $l | awk '{ print $1 }')"
    READLINE_LINE=$cmd
    READLINE_POINT=${#cmd}
  fi
}

gwt-cd(){
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      echo "Here is not inside git work tree"
      return
  fi
  GIT_CDUP_DIR=$(git rev-parse --show-cdup)
  GIT_TOPLEVEL_DIR=$(git rev-parse --show-toplevel)
  GIT_SUPERROOT_DIR=$(r=$(git rev-parse --git-dir) && r=$(cd "$r" && pwd)/ && echo "${r%%/.git/*}")
  branches=$(git branch --all | grep -v HEAD | cut -b 3- )
  commit_ish=$(echo "$branches" | "${filter[@]}")
  branchname=${commit_ish##*/}
  if [ -n "$branchname" ]; then
      cmd="git worktree add -b $branchname ${GIT_SUPERROOT_DIR}/worktrees/$branchname $commit_ish"
      echo $cmd
      $cmd
      local l="cd ${GIT_SUPERROOT_DIR}/worktrees/$branchname"
      READLINE_LINE=$l
      READLINE_POINT=${#l}
  fi
}
bind -r "\C-]"
bind -x '"\C-]p":gwt-cd'


gwt-ghq(){
  set-filter
  local src
  echo "${filter[@]}"
  src=$(ghq list | "${filter[@]}")
  if [ -n "$src" ]; then
    local l="cd $(ghq root)/$src"
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
  fi
}
bind -x '"\C-]g":gwt-ghq'


