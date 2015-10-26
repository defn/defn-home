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
  source "$APP_PATH/jq/script/profile"
  source "$APP_PATH/app/script/profile"
}

function bashrc {
  local shome="$(cd -P -- "${BASH_SOURCE%/*}" && pwd -P)"

  if [[ -z "${REQUIRE:-}" ]]; then
    export REQUIRE=1

    if [[ -f "$shome/.bashrc.app" ]]; then
      time source "$shome/.bashrc.app"
    else
      bootstraprc

      local tmp_rc="$(mktemp -t "XXXXXX")"
      export APP_RC_CACHE="$tmp_rc"

      time DEBUG=1 require

      local tmp_rc2="$shome/.bashrc.app.$(basename "$tmp_rc")"
      mv "$tmp_rc" "$tmp_rc2"
      mv -f "$tmp_rc2" "$shome/.bashrc.app"
    fi
  else
    bootstraprc
  fi

  configure_cue
  configure_tty
}

bashrc || echo WARNING: "Something's wrong with .bashrc"
