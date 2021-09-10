# Pyenv setup
if [[ -d "$HOME/.pyenv" ]]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"

        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path)"
fi

# Go PATH setup
if [[ -d "$HOME/go/bin" ]]; then
	export PATH="$HOME/go/bin:$PATH"
fi


# Yarn PATH setup
if [[ -d "$HOME/.yarn" ]]; then
	export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# NPM PATH setup
if [[ -d "$HOME/node_modules" ]]; then
	export PATH="$HOME/node_modules/bin:$PATH"
fi
