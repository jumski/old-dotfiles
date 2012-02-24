####### KOLORY
c_white="\[\e[37m\]"
c_celadon="\[\e[36m\]"
c_yellow="\[\e[33m\]"
c_green="\[\e[32m\]"
c_violet="\[\e[34m\]"
c_red="\[\e[31m\]"
c_reset="\[\e[0m\]"

function is_git_dirty {
  (git status | tail -n1 | grep -v "nothing to commit") 2> /dev/null >/dev/null
}
function is_git_repo {
  (git status | grep -v "Not a git repository") 2>/dev/null >/dev/null
}
function current_branch {
  echo $(git status 2>/dev/null | head -1 | awk {'print $4'})
}
function git_dirty_indicator {
  is_git_dirty && echo '*'
}
function git_indicator {
  if ! is_git_repo;
  then
    echo ''
    return
  fi

  echo "${c_yellow}[$(current_branch)${c_red}$(git_dirty_indicator)$(is_git_dirty)${c_yellow}]$c_reset "
}
function parse_rvm_prompt {
  rvm-prompt | sed 's/\(ruby-\)\(.*\)@\(.*\)/\3/'
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

function pwd_indicator {
  echo "${c_white}`basename "$PWD"`$c_reset "
}

function prompt_indicator {
  if [ $LAST_EXIT_CODE = 0 ];
  then
    indicator_color=$c_green
  else
    indicator_color=$c_red
  fi

  echo "${indicator_color}\$${c_reset} "
}

PROMPT_COMMAND='LAST_EXIT_CODE=$?;export PS1=" $(hostname_indicator)$(pwd_indicator)$(git_indicator)$(rails_env_indicator)$(prompt_indicator)"'
