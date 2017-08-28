# vim: sw=2 ts=2 et!
_auto_ls_should_display() {
  test -n "$(find . -type f -not -name .DS_Store)"
}

auto-ls () {
  if [[ $#BUFFER -eq 0 ]] && _auto_ls_should_display; then
    zle && echo ""
    exa
    echo ""
    
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == true ]]; then
      git status -s
    fi

    zle && zle redisplay
  else
    zle .$WIDGET
  fi
}

zle -N auto-ls
zle -N accept-line auto-ls
add-zsh-hook chpwd auto-ls
