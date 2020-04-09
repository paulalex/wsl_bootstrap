#!/usr/bin/env bash

function sync() {
  # Sync files to home directory
	rsync --exclude ".git/" \
	  --exclude ".gitignore" \
		--exclude "setup.sh" \
		--exclude "sync.sh" \
		-avh --no-perms . ~

	source ~/.bashrc
}

git pull origin master
sync
unset -f sync

 # Stop git asking for password every time you interact with remote
 git config --global credential.helper store

