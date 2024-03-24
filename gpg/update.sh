_update() {

	local HOME_FILES=()

	local dir=$(pwd)
	for file in "${HOME_FILES[@]}"; do
		if [ $1 == 'local' ]; then
			cp -v $dir/$file $HOME/$file
		elif [ $1 == 'remote' ]; then
			cp -v $HOME/$file $dir/$file
		fi
	done

	[ ! -d $HOME/.gnupg ] && mkdir $HOME/.gnupg
	[ ! -f $HOME/.gnupg/gpg.conf ] && touch $HOME/.gnupg/gpg.conf
	[ ! -f $HOME/.gnupg/gpg-agent.conf ] && touch $HOME/.gnupg/gpg-agent.conf

	if [ $1 == 'local' ]; then
		cp -v $dir/gpg.conf $HOME/.gnupg/gpg.conf
		cp -v $dir/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
	elif [ $1 == 'remote' ]; then
		cp -v $HOME/.gnupg/gpg.conf $dir/gpg.conf
		cp -v $HOME/.gnupg/gpg-agent.conf $dir/gpg-agent.conf
	fi
}

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
