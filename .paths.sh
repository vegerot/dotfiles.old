#Path stuff

## important stuff goes first
export PATH="$PATH"


## Unimportant stuff goes at the end
export PATH="$PATH:/usr/local/lib:$HOME/go/bin:$HOME/dotfiles/bin:$HOME/.local/bin"
. "$HOME/.cargo/env"

# make sure this is the last thing
export PATH="$PATH:."

