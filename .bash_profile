function bashprofile {
  time require
}

DEBUG=1 source ~/.bashrc
DEBUG=1 bashprofile || echo "INFO: something's wrong with script/profile"
