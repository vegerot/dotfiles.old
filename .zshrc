# add things to shell environment
source ~/.env
# Compute how long startup takes
start=`date +%s.%N`

# remove duplicates from PATH
typeset -aU path
typeset -U PATH

#start Tmux, maybe
#source ~/.profile

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

# This conflicts with tea's magic
#setopt correct

# increase maximum amount of open files in macOS
ulimit -n 512

# without this, oh-my-zsh enables `bracketed-paste-magic` and `url-quote-magic`
# which are freaking *slow*
DISABLE_MAGIC_FUNCTIONS=true

## OMZ bs
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="robbyrussell"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/workspace/github.com/facebook/sapling/eden/scm/contrib/scm-prompt.sh

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

plugins=(
	# line editing
	vi-mode
	fast-syntax-highlighting
	history-substring-search
	fzf

	# command completions
	git
	npm
	zsh-better-npm-completion

	colored-man-pages
)
source $ZSH/oh-my-zsh.sh


# User configuration

# set up keymap stuff here because it's not working other places
keymaps() {
	if [[ -z $DISPLAY ]]; then
		return
	fi
	local is_caps_already_mapped=$(xmodmap -pke | rg --count-matches "keycode\s+66\s*=\s*Control_L")
	if [[ $is_caps_already_mapped -gt 0 ]]; then
		return
	fi
	echo $is_caps_already_mapped
	echo "Caps is not mapped to Control_L, mapping it now"
	echo "caps is currently mapped to: $(xmodmap -pke | rg "keycode\s+66\s*= ")"
	xmodmap ~/.Xmodmap
	xcape
	setxkbmap -option ctrl:nocaps
	xcape -e 'Control_L=Escape'
}
keymaps

eval "$(jump shell)"

# fzf
## read by fzf program (see man fzf)
export FZF_DEFAULT_OPTS='--height=70% '
export FZF_DEFAULT_COMMAND='fd --no-require-git || git ls-tree -r --name-only HEAD'
# read by fzf/shell/key-bindings.zsh
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_PREVIEW_OPTS='--preview "bat --color always {} || cat {}" --preview-window=right:60%:wrap'
export FZF_CTRL_T_OPTS=$FZF_PREVIEW_OPTS

source "$HOME/.fzf-extras/fzf-extras.zsh"
source "$HOME/.fzf-extras/fzf-extras.sh"

# from fzf.zsh plugin
bindkey '^p' fzf-file-widget

# add more things to shell environment
source ~/.aliases
source ~/.sh_functions
randomcommand

# change cursor shape in vi mode
precmd_functions+=(zle-keymap-select)

zle-keymap-select () {
    if [[ $KEYMAP == vicmd ]]; then
        # the command mode for vi
        echo -ne "\e[2 q"
    else
        # the insert mode for vi
        echo -ne "\e[5 q"
    fi
}

# Bind j and k for history-substring-search in vim mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

## To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Only check compinit once a day
## credit: https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Compute time taken
end=`date +%s.%N`
runtime=$( echo "$end - $start"|bc -l )
echo "$runtime seconds"

