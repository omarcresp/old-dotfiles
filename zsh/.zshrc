# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DOTFILES=$HOME/.config/dotfiles

source $DOTFILES/zsh/antigen.zsh

# Load the oh-my-zsh's plugins.
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme.
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

# Load Powerlevel10k theme configuration.
[[ ! -f $DOTFILES/zsh/.p10k.zsh ]] || source $DOTFILES/zsh/.p10k.zsh

# enable autocomplete
autoload -Uz compinit
compinit -i

# history setup
setopt SHARE_HISTORY
# HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# Autosuggestions cycle through history
bindkey "^[[1;5A" history-beginning-search-backward
bindkey "^[[1;5B" history-beginning-search-forward

# End, Home keys mappings
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

# Ctrl+Left, Ctrl+Right keys mappings
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Vim mode
# ctrl + h, j, k, l
bindkey "^h" backward-word
bindkey "^j" down-line-or-history
bindkey "^k" up-line-or-history
bindkey "^l" forward-word

# bindkey "^J" history-beginning-search-forward
# bindkey "^K" history-beginning-search-backward

# Add go to path
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
# Add zoxide to ath
export PATH="$PATH:/home/jackcres/.local/bin"

# zoxide
eval "$(zoxide init zsh --cmd cd)"
source $DOTFILES/zsh/z_registry.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ssh change
alias s-work="rm -rf ~/.ssh && ln -s ~/.ssh-vammo ~/.ssh"
alias s-home="rm -rf ~/.ssh && ln -s ~/.ssh-omar ~/.ssh"

# nvim alias
alias vim=nvim
# alias vi=nvim
alias vi-dot="nvim ~/.zshrc"

# Load Angular CLI autocompletion.
# source <(ng completion script)

# Load tmux autocompletion for tm script (TODO: check why is not working)
# compdef _tmux tm
