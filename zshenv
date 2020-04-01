# Pyenv setup
if [[ -d "$HOME/.pyenv" ]]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"

	# Pyenv initialization
	if command -v pyenv 1>/dev/null 2>&1; then
	  eval "$(pyenv init -)"
	fi
fi

# Go PATH setup
if [[ -d "$HOME/go/bin" ]]; then
	export PATH="$HOME/go/bin:$PATH"
fi


# Yarn PATH setup
if [[ -d "$HOME/.yarn" ]]; then
	export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi
