[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"

function parse_git_branch {
  PS_BRANCH=''
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  PS_BRANCH="(${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_INFO="$BLUE\w"
PS_GIT="$RED\$PS_BRANCH"
PS_TIME="[\t]"
export PS1="\n\[\033[0G\]${PS_TIME} ${PS_INFO} ${PS_GIT}\n${RESET}\$ "
