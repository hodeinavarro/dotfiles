_update_darwin() {
	# Install zsh
	if ! command -v zsh &> /dev/null; then
		brew install zsh
		# Install as default shell
		chsh -s $(which zsh)
	fi

	# Install Oh My Zsh
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi

	# Add powerlevel10k theme
	if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
		git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	fi

	# Install Homebrew
	if ! command -v brew &> /dev/null; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
		eval "$(/opt/homebrew/bin/brew shellenv)"
		brew update && brew upgrade
	fi

	local BREW_PACKAGES=(
		'nano'
		'nanorc'
		'hiddenbar'
		'stats'
		'python@3.12'
		'postgresql@16'
		'gpg'
		'htop'
		'exiftool'
	)
	local BREW_SERVICES=(
		'postgresql@16'
	)
	local BREW_INSTALLED=$(brew list)

	for package in "${BREW_PACKAGES[@]}"; do
		if ! echo "$BREW_INSTALLED" | grep -q "$package"; then
			brew install $package
		fi
	done

	for service in "${BREW_SERVICES[@]}"; do
		if ! brew services list | grep -q "$service"; then
			brew services start $service
		fi
	done

	bash ./macos/defaults.sh
}

_update_linux() {
	echo ''
}

case $OSTYPE in
	darwin*)
		_update_darwin
		;;
	linux*)
		_update_linux
		;;
	*)
		echo "Unsupported OS"
		;;
esac
