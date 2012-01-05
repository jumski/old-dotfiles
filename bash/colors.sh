####### KOLORY
c_white="\[\e[37m\]"
c_celadon="\[\e[36m\]"
c_yellow="\[\e[33m\]"
c_green="\[\e[32m\]"
c_violet="\[\e[34m\]"
c_red="\[\e[31m\]"
c_reset="\[\e[0m\]"

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"
}
function parse_rvm_prompt {
  rvm-prompt | sed 's/\(ruby-\)\(.*\)@\(.*\)/\3/'
}

function get_color_hostname {
  case `hostname` in
    jumski-laptop)
      echo "${c_celadon}laptop$c_reset" ;;
    jumski-old)
      echo "${c_violet}old$c_reset" ;;
    jumski-akra)
      echo "${c_green}akra$c_reset" ;;
  esac
}

PROMPT_COMMAND='export PS1=" `get_color_hostname` $c_white`basename "$PWD"`$c_yellow [$(parse_git_branch)] $c_red $ $c_reset"'
