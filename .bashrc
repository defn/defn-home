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

function bashrc {
  local shome="$(unset CDPATH; cd -P -- "$(dirname -- "$BASH_SOURCE")" && pwd -P)"

  export APP_PATH="$shome/work"

  if bootstrap_app && require; then
    case "$(guess_scheme)" in 
      slight) slight || true ;;
      *)      sdark  || true ;;
    esac
  fi

  set +efu
}

DEBUG=1 bashrc || echo "INFO: something's wrong with script/profile"
