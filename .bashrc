function configure_cue {
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

  : ${CUE_SCHEME:="$(cat ~/.cue-scheme 2>&- || true)"}
  export CUE_SCHEME
  case "$(guess_scheme)" in
    slight) slight || true ;;
    *)      sdark  || true ;;
  esac
}

function bashrc {
  local shome="$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"

  export APP_PATH="$shome/work"
  if [[ -f "$APP_PATH/block/script/profile" ]]; then
    pushd "$APP_PATH/block" > /dev/null
    source "script/profile"
    require
    popd > /dev/null
  fi

  pushd "$shome" > /dev/null
  require
  popd > /dev/null

  if tty >/dev/null 2>&1; then
    configure_cue
  fi
}

bashrc || echo WARNING: "Something's wrong with .bashrc"
