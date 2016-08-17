function configure_cue {
  case "${TERM:-}" in
    screen*)
      TERM="screen-256color"
      ;;
    *)
      TERM="xterm-256color"
      ;;
  esac
  export TERM

  : ${SHLVL_INITIAL:=0}

  function guess_scheme {
    case "${TERM_PROGRAM:-}" in
      Apple_Terminal)
        echo slight
        ;;
      *)
        echo "${CUE_SCHEME:-${ITERM_PROFILE:-sdark}}"
        ;;
    esac
  }

  : ${CUE_SCHEME:="$(cat "$shome/.cue-scheme" 2>&- || true)"}
  export CUE_SCHEME
  case "$(guess_scheme)" in
    slight) slight || true ;;
    *)      sdark  || true ;;
  esac
}

function home_profile {
  local shome="$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"

  check_ssh_agent=1

  if ssh-add -l >/dev/null 2>&1; then
    check_ssh_agent=
  else
    case "$?" in
      1)
        check_ssh_agent=
        ;;
    esac
  fi

  if [[ -n "$check_ssh_agent" && -f "$HOME/.ssh-agent" ]]; then
    source "$HOME/.ssh-agent" >/dev/null
  fi

  source "$shome/.bashrc"

  if tty >/dev/null 2>&1; then
    configure_cue
  fi

  debug_on
}

home_profile
