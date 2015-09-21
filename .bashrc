export APP_PATH="$HOME/work"

function source_app {
  source "$APP_PATH/app/script/profile" || return 1
  source app_strict || return 1
  source app_shortcuts
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
  if sdark; then
    true
  fi
else
  echo "ERROR: something's wrong with script/profile"
fi

set +efux
