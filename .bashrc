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


if bootstrap_app && require; then
  case "${ITERM_PROFILE:-sdark}" in
    slight)
      if slight; then
        true
      fi
      ;;
    *)
      if sdark; then
        true
      fi
      ;;
  esac
else
  echo "INFO: something's wrong with script/profile"
fi
