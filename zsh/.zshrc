# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Auto-update behavior
zstyle ':omz:update' mode auto      # update automatically without asking

# How often to auto-update (in days).
zstyle ':omz:update' frequency 1

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Change the command execution time stamp shown in the history command output.
# See 'man strftime' for details.
HIST_STAMPS="%F %T"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nano'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$(brew --prefix python)/libexec/bin:$PATH"
export PATH="$(brew --prefix postgresql@16)/bin:$PATH"
export LDFLAGS="-L/$(brew --prefix postgresql@16)/lib"
export CPPFLAGS="-I/$(brew --prefix postgresql@16)/include"
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix openssl)/lib/
export PATH="$(brew --prefix openssl)/bin:$PATH"

export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

. "$HOME/.cargo/env"

[ -f ~/.zshrc.aliases.public ] && source ~/.zshrc.aliases.public
[ -f ~/.zshrc.aliases.private ] && source ~/.zshrc.aliases.private
