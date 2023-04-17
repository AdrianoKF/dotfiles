# Poetry PATH setup
if [[ -d "$HOME/.poetry/bin" ]]; then
	export PATH="$HOME/.poetry/bin:$PATH"
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

# Kubectl Krew PATH setup
if [[ -d "$HOME/.krew/bin" ]]; then
	export PATH="${HOME}/.krew/bin:$PATH"
fi

# VIM as default editor
export EDITOR=vim

# Fix gcloud warning
#   To increase the performance of the tunnel, consider installing NumPy. For instructions,
#   please see https://cloud.google.com/iap/docs/using-tcp-forwarding#increasing_the_tcp_upload_bandwidth
# See: https://cloud.google.com/iap/docs/using-tcp-forwarding#increasing_the_tcp_upload_bandwidth
export CLOUDSDK_PYTHON_SITEPACKAGES=1.

# Fix for VS Code Live Share being broken
# See:
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

export QT_QPA_PLATFORMTHEME=qt5ct
