export CUE_SCHEME="$(cat ~/.cue_scheme 2>&- || true)"

function source_app {
  source "$APP_PATH/app/script/profile" || return 1
  source "$APP_PATH/jq/script/profile" || return 1
}

function bootstrap_app {
  if ! type require 2>&- >/dev/null; then
    if ! source_app; then
      echo "ERROR: someting's wrong with app/script/profile"
      return 1
    fi
  fi
}

function guess_scheme {
  echo "${CUE_SCHEME:-${ITERM_PROFILE:-sdark}}"
}

function bashprofile {
  local shome="$(unset CDPATH; cd -P -- "$(dirname -- "$BASH_SOURCE")" && pwd -P)"

  source "$shome/.profile.d/app.pre"

  if bootstrap_app && require; then
    case "$(guess_scheme)" in 
      slight) slight || true ;;
      *)      sdark  || true ;;
    esac
  fi
}

DEBUG=1 bashprofile || echo "INFO: something's wrong with script/profile"

source ~/.bashrc || echo "ERROR: something's wrong with bashrc"

if tty 2>&- > /dev/null; then
  set +efu
fi

