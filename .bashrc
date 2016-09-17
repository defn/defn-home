function source_blocks {
  if [[ -f "$shome/work/block/script/profile" ]]; then
    source "$shome/work/block/script/profile" "$shome"
    if block gen profile > $shome/.bashrc.cache.$$; then
      mv $shome/.bashrc.cache.$$ $shome/.bashrc.cache
    fi
  fi
}

function source_cache {
  source "$shome/.bashrc.cache"
  _profile
}

function bashrc {
  local shome="$(cd -P -- "${BASH_SOURCE%/*}/.." && pwd -P)"

  if [[ -f "$shome/.bashrc.cache" ]]; then
    if ! source_cache; then
      source_blocks
    fi
  else
    source_blocks
  fi

  if [[ -f "$shome/exec/home_secret" ]]; then
    source "$shome/exec/home_secret"
  fi
}

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

function set_scheme {
  if type -t sdark >/dev/null; then
    case "$(guess_scheme)" in
      slight) slight || true ;;
      *)      sdark  || true ;;
    esac
  fi
}

function home_bashrc {
  local shome="$(cd -P -- "${BASH_SOURCE%/*}/.." && pwd -P)"

  PATH="$(echo $PATH | tr ':' '\n' | uniq | grep -v "$shome" | grep -v "${PKG_HOME:-"$shome"}" | perl -ne 'm{^\s*$} && next; s{\s*$}{:}; print')"
  if [[ "$(type -t require)" != "function" ]]; then
    if bashrc; then
      set_scheme
    else
      echo WARNING: "Something's wrong with .bashrc"
    fi
  fi
}

home_bashrc
