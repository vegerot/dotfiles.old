# Compute how long startup takes
start=`gdate +%s.%N`
# Command line editing
setopt vi
autoload -U edit-command-line
zle -N edit-command-line
## 10ms for key sequences
KEYTIMEOUT=1
bindkey -M vicmd "" edit-command-line


# History
HISTSIZE=1073741823000
SAVEHIST=$HISTSIZE
HIST_EXPIRE_DUPS_FIRST=1
export HISTSIZE
export SAVEHIST
export HIST_EXPIRE_DUPS_FIRST

setopt EXTENDED_HISTORY
setopt histexpiredupsfirst
setopt incappendhistorytime

unsetopt histignorespace



## OMZ bs
# Path to your oh-my-zsh installation.
export ZSH="/Users/m0c0j7y/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

plugins=(
	git
	vi-mode
)




source $ZSH/oh-my-zsh.sh

# User configuration


source ~/.env
source ~/.aliases

# Compute time taken
end=`gdate +%s.%N`
runtime=$( echo "$end - $start"|bc -l )
echo "$runtime seconds"


