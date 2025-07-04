export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell" # set by `omz`
# ZSH_THEME="robbyrussell" # set by `omz`
# ZSH_THEME="avit" # set by `omz`

plugins=(git postgres docker battery zsh-transient-prompt)

source $ZSH/oh-my-zsh.sh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e

# End of lines configured by zsh-newuser-install
# sugon
# if command -v "figlet" &> /dev/null &&
#    command -v "lolcat" &> /dev/null;
# then
#     figlet -f Speed "SugoN" | lolcat
# fi
# end sugon

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

bindkey -v

# Fixing zsh history problems on multiple terminals
setopt inc_append_history
setopt share_history

# Ignore duplicate commands in history file
setopt histignorealldups

# Fixing some keys inside zsh
autoload -Uz select-word-style
select-word-style bash

# Add highlight enabled tab completion with colors
zstyle ':completion:*' menu select
eval "$(dircolors)"
LS_COLORS=$LS_COLORS:'ow=1;94:'; export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Get bash's compgen
autoload -Uz compinit
compinit
autoload -Uz bashcompinit
bashcompinit

# Sourcing the different plugins I have in zsh
source $HOME/.plugins.zsh
eval "$(zoxide init zsh)"

# source fuzzy find
# instructions to install fzf are found on github
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
# end

# ROS setup file
# source /opt/ros/noetic/setup.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh


# add binaries to $PATH
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/sbin:/bin
export PATH=$PATH:/usr/games
export PATH=$PATH:/usr/local/games
export PATH=$PATH:/snap/bin
export PATH=$PATH:/usr/lib/cuda/bin
export PATH=$PATH:/usr/local/cuda/bin:/opt/cuda/bin
export PATH=$PATH:/home/kp/.local/bin
export PATH=$PATH:/home/kp/.local/share/gem/ruby/3.4.0/bin


export LC_ALL="en_GB.UTF-8" 
export QT_QPA_PLATFORMTHEME=qt6ct
# end of $PATH exports

# bash's command not found auto suggest
command_not_found_handler () {
    if [ -x /usr/lib/command-not-found ]
    then
        /usr/lib/command-not-found -- "$1"
        return $?
    else
        if [ -x /usr/share/command-not-found/command-not-found ]
        then
            /usr/share/command-not-found/command-not-found -- "$1"
            return $?
        else
            printf "%s: command not found\n" "$1" >&2
            return 127
        fi
    fi
}

# getting Emacs tramp to work with zsh
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PS1='$ '
fi

# custom ZSH keybinds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# if command -v "emacs" &> /dev/null; then bindkey -s "^[e" "emacsclient -c . &; disown %1; ^M"; fi
if command -v "nvim" &> /dev/null; then bindkey -s "^[e" "nvim "; fi
if command -v "neovide" &> /dev/null; then bindkey -s "^[E" "devour neovide . --nofork; "; fi
if command -v "nautilus" &> /dev/null; then bindkey -s "^[n" "nautilus . &!; exit; "; fi
# end

# loop through and source all aliases files
for aliases_file in $(\ls -a $HOME | \grep -E "\.aliases.*\.zsh"); do
    source $HOME/$aliases_file
done

# set editor
export EDITOR="/usr/bin/nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# eval "$(starship init zsh)"


# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias v=nvim
alias vi=nvim
alias cdwin="cd /mnt/win/"
alias tmux="tmux -u"
alias la="ls -a"
alias ll="ls -l"
alias cat=bat
alias p=python
alias p3=python3
alias c=clear
alias clera=clear
alias claer=clear
alias quit=exit
alias :q=exit
alias qq=exit
alias fuck="thefuck"
alias F="thefuck"
alias rgr="ranger"

alias ls='eza --group-directories-first --icons'
alias ll='eza --group-directories-first --icons -lh'
alias la='eza --group-directories-first --icons -a'
alias lla='eza --group-directories-first --icons -lah'
alias lsa='eza --group-directories-first --icons -lah'
alias lsf='ls | grep -i '

alias ..='cd ./..'
alias .2='cd ./../..'
alias .3='cd ./../../..'
alias .4='cd ./../../../..'

function mkcd {
    mkdir -p $@
    z $1
}

alias gs="git status"
alias gp="git push"
alias gc="git commit -m"
alias ga="git add"
alias gd="git diff"
alias gpu="git pull"
alias gf="git fetch"
alias gr="git restore"

alias gl="git log"
alias glob="git --no-pager log --oneline --graph -n 15"

alias gst="git --no-pager stash"

alias asdc="tmuxifier s asdc"
alias asds="tmuxifier s asds"

alias pacs="sudo pacman -S"
alias pacq="pacman -Q"
alias pacr="sudo pacman -R"

alias edge="microsoft-edge-stable"

alias sopy="source ./.venv/bin/activate"

alias cpc="xclip -sel c < "
alias gv="gwenview "
alias ff="firefox "

alias bye="shutdown now"
alias brb="sudo reboot now"

function cdls() {
    z $@
    eza --group-directories-first --icons=always
}
alias cd="cdls"

function wpsend() {
    ffmpeg -i $@ -c:v libx264 -profile:v baseline -level 3.0 -pix_fmt yuv420p "WP_${@}"
}

alias cdi="zi"
alias dol="dolphin "

alias bd="blobdrop "

# Run Fastfetch
# if [[ -o interactive ]]; then
#     # fastfetch -l small
#     fastfetch --logo-width 49 --logo-height 23 --kitty ~/.config/fastfetch/pngs/MinimalistWaves_Sq_NoBG.png
#     echo "\n"
# fi

TRANSIENT_PROMPT_PROMPT=" 
%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
TRANSIENT_PROMPT_PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

TRANSIENT_PROMPT_TRANSIENT_PROMPT=" %(?:%{$fg_bold[green]%}%1{➜%} "
