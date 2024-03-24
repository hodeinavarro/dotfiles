_update() {
	local HOME_FILES=('.zshrc' '.p10k.zsh')

	local dir=$(pwd)
	for file in "${HOME_FILES[@]}"; do
		if [ $1 == 'local' ]; then
			cp -v $dir/$file $HOME/$file
		elif [ $1 == 'remote' ]; then
			cp -v $HOME/$file $dir/$file
		fi
	done
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
