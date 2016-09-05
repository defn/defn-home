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

  : ${CUE_SCHEME:="$(cat "$shome/.cue-scheme" 2>/dev/null || true)"}
  export CUE_SCHEME
}

function home_profile {
  local shome="$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"

  local check_ssh_agent=1

  if ssh-add -l >/dev/null 2>&1; then
    check_ssh_agent=
  else
    case "$?" in
      1)
        check_ssh_agent=
        ;;
    esac
  fi

  if [[ -n "$check_ssh_agent" && -f "$shome/.ssh-agent" ]]; then
    source "$shome/.ssh-agent" >/dev/null
  fi

  source "$shome/.bashrc"

  if tty >/dev/null 2>&1; then
    configure_cue
  fi
}

home_profile
