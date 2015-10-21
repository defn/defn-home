function bashprofile {
  require
}

time DEBUG=1 source ~/.bashrc
time DEBUG=1 bashprofile || echo "INFO: something's wrong with script/profile"
