PATH="$(echo $PATH | tr ':' '\n' | uniq | grep -v "$HOME" | grep -v "${PKG_HOME:-dont-find-anything}" | perl -ne 'm{^\s*$} && next; s{\s*$}{:}; print')"

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

function bashrc {
  local shome="${_defn_home_home:-"$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"}"

  source "$shome/work/block/script/profile" "$shome"

  if tty >/dev/null 2>&1; then
    configure_cue
  fi
}

if [[ -z "${BLOCK_PATH:-}" || "${BLOCK_PATH:-}" == "$HOME/work" ]]; then
  bashrc || echo WARNING: "Something's wrong with .bashrc"
fi
