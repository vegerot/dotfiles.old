#Path stuff

## important stuff goes first
export PATH="$HOME/.cargo/bin:$PATH"

## Unimportant stuff goes at the end
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/lib:$GOPATH/bin:$HOME/dotfiles/bin"

# pnpm
export PNPM_HOME="/home/max/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# sledge:binary path
#export SLEDGE_BIN="$HOME/.sledge/bin"
#export PATH="${PATH}:${SLEDGE_BIN}"


# cargo
#. "$HOME/.cargo/env"

# make sure this is the last thing
export PATH="$PATH:."

### MAN path

export MANPATH="/usr/local/share/man:$MANPATH:"

# setup pyenv

#if command -v pyenv 1>/dev/null 2>&1; then
if false; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi
