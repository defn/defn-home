function configure_cue {
  : ${SHLVL_INITIAL:=0}
  require cue

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

function configure_tty {
  if tty 2>&- > /dev/null; then
    set +efu
  fi
}

function bootstraprc {
  source "$shome/.profile.d/app.pre"
  source "$APP_PATH/sub/script/profile"
  source "$APP_PATH/jq/script/profile"
  source "$APP_PATH/app/script/profile"
}

function bashrc {
  local shome="$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"

  if [[ -z "${REQUIRE:-}" ]]; then
    export REQUIRE=1

    if [[ -f "$shome/.bashrc.app" ]]; then
      source "$shome/.bashrc.app"
    else
      bootstraprc
      require
    fi
  else
    bootstraprc
  fi

  configure_cue
  configure_tty
}

bashrc || echo WARNING: "Something's wrong with .bashrc"
