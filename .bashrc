function guess_scheme {
  echo "${CUE_SCHEME:-${ITERM_PROFILE:-sdark}}"
}

function bashrc {
  local shome="$(unset CDPATH; cd -P -- "$(dirname -- "$BASH_SOURCE")" && echo "$PWD")"

  source "$shome/.profile.d/app.pre"
  source "$APP_PATH/app/script/profile"

  require cue

  : ${CUE_SCHEME:="$(cat ~/.cue-scheme 2>&- || true)"}
  export CUE_SCHEME
  case "$(guess_scheme)" in
    slight) slight || true ;;
    *)      sdark  || true ;;
  esac

  if tty 2>&- > /dev/null; then
    set +efu
  fi
}

bashrc || echo WARNING: "Something's wrong with .bashrc"
