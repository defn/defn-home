check_ssh_agent=1

if ssh-add -l >/dev/null 2>&1; then
	check_ssh_agent=
else
  case "$?" in
    1)
	    check_ssh_agent=
      ;;
  esac
fi

if [[ -n "$check_ssh_agent" && -f "$HOME/.ssh-agent" ]]; then
  source "$HOME/.ssh-agent" >/dev/null
fi

source ~/.bashrc
