#!/usr/bin/bash

function sync() {
  # Sync files to home directory
	rsync --exclude ".git/" \
	  --exclude ".gitignore" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "dotfiles.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~

	source ~/.bashrc
}

git pull origin master
sync
unset -f sync

 # Stop git asking for password every time you interact with remote
 git config --global credential.helper store

