#!/usr/bin/env bash

GWT_DIR=${GWT_DIR:-~/.git-worktrees/}
GWT_REPOS_DIR=${GWT_REPOS_DIR:-~/.ghq/}

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

peco-gwt-cd(){
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      echo "Here is not inside git work tree"
      return
  fi
  GIT_CDUP_DIR=$(git rev-parse --show-cdup)
  GIT_TOPLEVEL_DIR=$(git rev-parse --show-toplevel)
  GIT_SUPERROOT_DIR=$(r=$(git rev-parse --git-dir) && r=$(cd "$r" && pwd)/ && echo "${r%%/.git/*}")
  branches=$(git branch --all | grep -v HEAD | cut -b 3- )
  commit_ish=$(echo "$branches" | fzf )
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
bind -x '"\C-]p":peco-gwt-cd'


#ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*"
#ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'"

ghq-fzf(){
  local src
  src=$(ghq list | fzf --preview "batcat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    local l="cd $(ghq root)/$src"
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
  fi
}
#cdgwt(){
#    branches=$(git branch -vv) &&
#    branch=$(echo "$branches" | fzf +m) &&
#    git worktree 
#
#}
bind -x '"\C-]g":ghq-fzf'


