#!/usr/bin/env bash

_get_default_branch() {
    # Try to get the default branch from the remote
    local remote_head=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null)
    if [ -n "$remote_head" ]; then
        local remote=$(echo "$remote_head" | sed 's@^refs/remotes/origin/@@')
        echo "$remote"
    else
        # Get the default branch from the config
        local defaultBranch=$(git config --get init.defaultBranch)
        echo "${defaultBranch:-main}"
    fi
}

_update() {
	if [ $1 == 'remote' ]; then
		# Make sure we are on the default branch
		# Might be master, main, or another name
		local current=$(git branch --show-current)
		local default=$(_get_default_branch)
		if [ "$current" != "$default" ]; then
			echo "Not on the default branch"
			exit 1
		fi

		# Create a new branch for the update
		git checkout -b update-$(date +%d-%m-%Y_%H-%M-%S)
	fi

	# For each folder in this repository, call its appropriate handler
	for folder in $(ls -d */); do
		folder=${folder%?}
		if [ -f "$folder/update.sh" ]; then
			echo "Updating $folder"
			(cd $folder && bash update.sh $@)
		else
			echo "No update script found for $folder"
		fi
	done
}

# Usage:
# bash update.sh local or bash update.sh remote

case $1 in
	"local")
		_update local
		;;
	"remote")
		_update remote
		;;
	*)
		echo "Usage: bash update.sh local or bash update.sh remote"
		;;
esac
