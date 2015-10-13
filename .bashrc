function source_app {
  local shome="$(unset CDPATH; cd -P -- "$(dirname -- "$BASH_SOURCE")" && pwd -P)"

  export APP_PATH="$shome/work"

  source "$APP_PATH/app/script/profile" || return 1

  require jq

  require Blockfile
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
  if bootstrap_app && require; then
    case "$(guess_scheme)" in 
      slight) slight || true ;;
      *)      sdark  || true ;;
    esac
  fi

  set +efu
}

bashrc || echo "INFO: something's wrong with script/profile"
