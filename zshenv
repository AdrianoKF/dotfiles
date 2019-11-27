if [[ -d "$HOME/.pyenv" ]]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"

	# Pyenv initialization
	if command -v pyenv 1>/dev/null 2>&1; then
	  eval "$(pyenv init -)"
	fi
fi
