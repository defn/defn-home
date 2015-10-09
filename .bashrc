export APP_PATH="$HOME/work"

function source_app {
  source "$APP_PATH/app/script/profile" || return 1
}

function bootstrap_app {
  if ! type require 2>&- >/dev/null; then
    if ! source_app; then
      echo "ERROR: someting's wrong with $APP_PATH/app/script/profile"
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
