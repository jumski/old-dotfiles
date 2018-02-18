####### KOLORY
c_white="\[\e[37m\]"
c_celadon="\[\e[36m\]"
c_yellow="\[\e[33m\]"
c_green="\[\e[32m\]"
c_violet="\[\e[34m\]"
c_red="\[\e[31m\]"
c_reset="\[\e[0m\]"

gitdir()
{
    local dir="$(pwd)"
    while [ "$(dirname $dir)" != "/" ]; do
        [ -d "$dir/.git" ] && echo "$dir/.git" && return
        dir="$(dirname $dir)"
    done
    false
}

function is_git_dirty {
  (git status | tail -n1 | grep -v "nothing to commit") 2> /dev/null >/dev/null
}
function is_git_repo()
{
    local dir="$(pwd)"
    while [ "$(dirname "$dir")" != "/" ]; do
        [ -d "$dir/.git" ] && return
        dir="$(dirname "$dir")"
    done
    false
}
function current_branch {
  cat `gitdir`/HEAD | sed 's|ref: refs/heads/||'
}
function git_dirty_indicator {
  is_git_dirty && echo '*'
}
function git_indicator {
  if [ -n "$DISABLE_GIT_INDICATOR" ]; then
    return
  fi

  if ! is_git_repo;
  then
    echo ''
    return
  fi

  # sanitize branch name to avoid pwnage
  # https://github.com/njhartwell/pw3nage
  branch=$(current_branch)
  branch=${branch//[^a-z0-9\/]/-}

  echo "${c_yellow}[${branch}${c_red}$(git_dirty_indicator)${c_yellow}]$c_reset "
}
function rails_env_indicator {
  [ "$RAILS_ENV" = "production" ] && echo "${c_red}P$c_reset "
}

function hostname_indicator {
  case `hostname` in
    jumski-laptop)
      echo "${c_celadon}laptop$c_reset " ;;
    jumski-old)
      echo "${c_violet}old$c_reset " ;;
    jumski-akra)
      echo "${c_green}akra$c_reset " ;;
    s11.linuxpl.com)
      echo "${c_yellow}linuxpl$c_reset " ;;
  esac
}

function shortened_pwd {
  dirname "`pwd`" | sed 's:\B\w*::g'

}
function parent_dirname {
  dirname "`pwd`" | sed 's|/\(.*\)\+/\(.*\)|\2|g'
}

function pwd_indicator {
  echo "`parent_dirname `/${c_white}`basename "$PWD"`$c_reset "
  # echo "`parent_dirname | head -c1 `/${c_white}`basename "$PWD"`$c_reset "
}

source $DOTFILES_PATH/bash/battery_functions.sh

function prompt_indicator {
  if [ $LAST_EXIT_CODE = 0 ];
  then
    indicator_color=$c_green
  else
    indicator_color=$c_red
  fi

  echo "${indicator_color}\$${c_reset} "
}

prompt_command() {
  LAST_EXIT_CODE=$?
  history -a
  export PS1="\n$(hostname_indicator)$(pwd_indicator)$(git_indicator)$(rails_env_indicator)\n$(prompt_indicator)"
}

PROMPT_COMMAND=prompt_command
