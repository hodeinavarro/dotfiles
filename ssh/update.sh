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

	[ ! -d $HOME/.ssh ] && mkdir $HOME/.ssh
	[ ! -f $HOME/.ssh/config ] && touch $HOME/.ssh/config
	[ ! -f $HOME/.ssh/public/config ] && touch $HOME/.ssh/public/config
	if [ $1 == 'local' ]; then
		cp -v $dir/config $HOME/.ssh/config
		cp -v $dir/public.config $HOME/.ssh/public/config
	elif [ $1 == 'remote' ]; then
		cp -v $HOME/.ssh/config $dir/config
		cp -v $HOME/.ssh/public/config $dir/public.config
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
