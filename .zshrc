# ~/.zshrc
# https://github.com/ohmyzsh/ohmyzsh
# https://github.com/ohmyzsh/ohmyzsh/wiki

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/areza/.oh-my-zsh"

# these 3 lines must be set by the terminal emulator itself
# for example st, tmux, xterm ....
# uncomment in necessary momments.
#export TERM="xterm-256color"
#export TERM="tmux-256color"
#export TERM="st-256color"

#powerlevel custom settings
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time anaconda)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S | %d.%m.%y}"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	docker
	#docker-compose
	#docker-machine
	z
	ros
	tmux
	vi-mode
	command-not-found
	# custom plugin for conda completion.
	# you must clone its repo for usage. run bellow command for it:
	# git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
	# for more information go to the top of the "_conda" file in its repository.
	conda-zsh-completion
	fzf
	#git-prompt
	#git-extras # install git-extras from pamac manager and uncomment this to use
	#git-flow
	#git-flow-avh
	# use bellow address to install gitflow for dependency of git-hubflow plugin 
	# https://github.com/datasift/gitflow#installation
	# https://datasift.github.io/gitflow/
	#git-hubflow
	#gitignore # at the end of this file gi function for dependency of gitignore is added. you must install gi function before use this plugin.
	#pip
	#themes
	#zsh_reload # To reload the zsh session, just run src
	#battery
	#kate
	#ssh-agent # have some settings. for more info go to : https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#####################################################################
#####################################################################

# set vi-mode visual for full neovim command editing environment
export VISUAL="nvim"

#####################################################################
#####################################################################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/areza/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/areza/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/areza/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/areza/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#####################################################################
#####################################################################

source /opt/ros/noetic/setup.zsh

#####################################################################
#####################################################################

# <<< PlatformIO commands to be available >>>
export PATH=$PATH:~/.platformio/penv/bin

#####################################################################
#####################################################################

# fzf plugin for zsh
export FZF_BASE=/usr/bin/fzf
DISABLE_FZF_AUTO_COMPLETION="false"

# After solving the conflicts of st terminal clipcopy and fzf key bindings now
# we can use the default key bindings of fzf on zsh.
DISABLE_FZF_KEY_BINDINGS="false"

# you can also disable the default key bindings and define them for yourself by
# uncommenting the bellow lines.
# from : https://github.com/junegunn/fzf/issues/546
# DISABLE_FZF_KEY_BINDINGS="true"
# bindkey '^T' fzf-file-widget
# bindkey '^R' fzf-history-widget
# bindkey '^J' fzf-cd-widget

#####################################################################
#####################################################################

# from : https://github.com/junegunn/fzf
# installation script has added this bellow line. note that in the main repo
# it is recommended to use this script for both bash and zsh for full support.
# distro binaries does not have some features by default.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# from : https://github.com/junegunn/fzf/wiki/Examples#cd
# to have as same as bash options on zsh. for example you can change through
# parent directories (i think! I have not used them yet).
#####################################################################
# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}


#####################################################################
#####################################################################

# This is for gi command that automatically generates the '.gitignore' file
# for various types of projects. Bellow addresses are related to this command
# https://www.toptal.com/developers/gitignore
# https://docs.gitignore.io/install/command-line
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

#####################################################################
#####################################################################




#####################################################################
#####################################################################




