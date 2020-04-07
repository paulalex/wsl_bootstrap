#!/usr/bin/bash

function sync() {
  # Sync files to home directory
	rsync --exclude ".git/" \
	  --exclude ".gitignore" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "dotfiles.sh" \
		-exclude "brew.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~

	source ~/.bash_profile
}

git pull origin master
sync
unset -f sync

