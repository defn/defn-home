#!/usr/bin/env bash

function main {
  set -x

  cd

  echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfchHJtADoZClQITn1qFK7Jy7B9tje/dCFLzrqpdmOyUhmz9zGTjwmL7hXxuyPZgAcdrGPKE+3DjpqqEIxfem1hta0Ej6O8ad/9z0x+xBe2G1EFADYi5gdHuU3+Fh/hUUDWKnQKO0UlAewk488yIUYUU+UVcaPXr9pF1U5VfW8bue76ML9sdR9qIGP2Va+bJhX8neMffc79ShEd02kqVg0kSeQduCK5rNg51wWVNoCe6gvkufuAGvwVOh/jWwGvEsOMcqOFUipKi1ltCqu8vwheTSzLxGUuOUKBedxFjCip0xeZzCP+hFxxS56FaqcRqrsoLTQdWOWduRrWNFlXyxn defn@spiral.local' >> ~/.ssh/authorized_keys

  ssh -oStrictHostKeyChecking=no github.com true
  ssh -oStrictHostKeyChecking=no bitbucket.org true
  ssh -oStrictHostKeyChecking=no localhost true

  git clone git@github.com:defn/home home
  mv home/.git .
  git reset --hard
  rm -rf home
  git clean -fd

  git clone git@github.com:defn/app work/app
  pushd work/app
  script/bootstrap
  set +x
  source script/profile
  set -x
  popd

  script/bootstrap
  set +x
  source script/profile
  set -x
  app bootstrap
}

main "$@"
