# Helpers
# safe source
function safe_source {
  [ -f "$1" ] && source "$1"
}

# check if program is available
function has_program {
  hash $1 2>/dev/null
}

## Fancy prompt
red='\[\e[0;31m\]'
RED='\[\e[1;91m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;94m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;96m\]'
black='\[\e[0;30m\]'
BLACK='\[\e[1;90m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;92m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;93m\]'
magenta='\[\e[0;35m\]'
MAGENTA='\[\e[1;95m\]'
white='\[\e[0;37m\]'
WHITE='\[\e[1;97m\]'
NC='\[\e[0m\]'

function is_vim_running {
  jobs | grep -o 'vim' &> /dev/null
}

function is_direnv_dir {
  [[ -n "${DIRENV_DIR}" ]]
}

PROMPT_INFO="${BLACK}[\A] ${green}\u${NC} ${BLUE}\w"
PROMPT_DIRENV="\$(is_direnv_dir && echo \"*\")"
PROMPT_GIT="${GREEN}\$(__git_ps1)"
PROMPT_FOOTER="\n\$(is_vim_running && echo \"${red}\" || echo \"${BLACK}\")↳ ${GREEN}\$ ${NC}"
PS1="${PROMPT_INFO}${PROMPT_DIRENV}${PROMPT_GIT} ${PROMPT_FOOTER}"

# Disable console start/stop: makes ^S and ^Q go through
stty -ixon

## Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;91m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;93m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;92m'

## Load direnv
has_program direnv && eval "$(direnv hook bash)"

## Load asdf
safe_source "$HOME/.asdf/asdf.sh"
safe_source "$HOME/.asdf/completions/asdf.bash"

# chruby support
[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

# homebrew support
[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

# dev support
[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

## Load secrets
safe_source "$HOME/.bash_secrets"

## Utilities
# go back n directories
function b {
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# extract files: depends on zip, unrar and p7zip
function ex {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via ex()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# mkdir && cd
function mkcd {
  mkdir -p "$1" && cd "$1";
}

# find or create tmux session
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# repeat command
function repeat() {
  number=$1
  shift
  for n in $(seq $number); do
    if ! $@; then
      echo "Sorry, something failed!"
      return 1
    fi
  done
  return 0
}

# last rails migration
function echo_last_migration {
  migrate_path="db/migrate/"
  nth_migration=$((${1:-0}+1))
  echo "${migrate_path}$(ls -1t $migrate_path | head -$nth_migration | tail -1)"
}

function last_migration {
  vim `echo_last_migration $*`
}

# find and edit
function find_and_edit () {
  if test -d .git
  then
    SOURCE="$(git ls-files)"
  else
    SOURCE="$(find . -type f)"
  fi
  files="$(fzf --preview='bat --color=always --paging=never --style=changes {} | head -$FZF_PREVIEW_LINES' --select-1 --multi --query="$@" <<< "$SOURCE")"
  if [[ "$?" != "0" ]]
  then
    return 1
  fi
  vim $files
}

## Some random fortune
shopt -q login_shell && has_program fortune && fortune -s
