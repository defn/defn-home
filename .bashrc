function configure_cue {
  case "${TERM:-}" in
    screen*)
      TERM="screen-256color"
      ;;
    *)
      TERM="xterm-256color"
      ;;
  esac
  export TERM

  : ${SHLVL_INITIAL:=0}

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

  : ${CUE_SCHEME:="$(cat ~/.cue-scheme 2>&- || true)"}
  export CUE_SCHEME
  case "$(guess_scheme)" in
    slight) slight || true ;;
    *)      sdark  || true ;;
  esac
}

function source_blocks {
  source "$shome/work/block/script/profile" "$shome"
  block gen profile > $shome/.bashrc.cache.$$
  mv $shome/.bashrc.cache.$$ $shome/.bashrc.cache
}

function source_cache {
  source "$shome/.bashrc.cache"
  _profile
}

function bashrc {
  local shome="${_defn_home_home:-"$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"}"

  if [[ -f "$shome/.bashrc.cache" ]]; then
    if ! source_cache; then
      source_blocks
    fi
  else
    source_blocks
  fi

  if tty >/dev/null 2>&1; then
    configure_cue
  fi
}

function setup {
  PATH="$(echo $PATH | tr ':' '\n' | uniq | grep -v "$HOME" | grep -v "${PKG_HOME:-dont-find-anything}" | perl -ne 'm{^\s*$} && next; s{\s*$}{:}; print')"
  if [[ -z "${BLOCK_PATH:-}" || "${BLOCK_PATH:-}" == "$HOME/work" ]]; then
    bashrc || echo WARNING: "Something's wrong with .bashrc"
  fi
}

time setup
