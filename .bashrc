function configure_cue {
  : ${SHLVL_INITIAL:=0}

  function guess_scheme {
    echo "${CUE_SCHEME:-${ITERM_PROFILE:-sdark}}"
  }

  : ${CUE_SCHEME:="$(cat ~/.cue-scheme 2>&- || true)"}
  export CUE_SCHEME
  case "$(guess_scheme)" in
    slight) slight || true ;;
    *)      sdark  || true ;;
  esac
}

function bashrc {
  local shome="$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"

  source "$shome/work/jq/script/profile"
  source "$shome/work/app/script/profile"

  if tty 2>&1 >/dev/null; then
    require
    configure_cue
    set +exfu
  fi
}

bashrc || echo WARNING: "Something's wrong with .bashrc"
