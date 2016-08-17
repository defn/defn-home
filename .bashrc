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

  if [[ -f "$shome/exec/home_secret" ]]; then
    source "$shome/exec/home_secret"
  fi
}

function home_bashrc {
  local shome="${shome:-"$(cd -P -- "$(dirname "${BASH_SOURCE}")" && pwd -P)"}"

  PATH="$(echo $PATH | tr ':' '\n' | uniq | grep -v "$shome" | grep -v "${PKG_HOME:-dont-find-anything}" | perl -ne 'm{^\s*$} && next; s{\s*$}{:}; print')"
  if [[ -z "${BLOCK_PATH:-}" || "${BLOCK_PATH:-}" == "$shome/work" ]]; then
    bashrc || echo WARNING: "Something's wrong with .bashrc"
  fi
}

home_bashrc
