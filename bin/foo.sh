#!/usr/bin/env bash

function main {
  set -x
  ssh -oStrictHostKeyChecking=no github.com true
  ssh -oStrictHostKeyChecking=no bitbucket.org true
  git clone git@github.com:defn/home home
  mv home/.git .
  git reset --hard
  rm -rf home
  git clean -fd

  script/bootstrap || true
  source script/profile
  require
  app bootstrap
}

main "$@"
