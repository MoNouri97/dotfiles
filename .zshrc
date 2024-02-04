# active# If you come from bash you might have to change your $PATH.
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export LC_ALL="en_US.UTF-8"

# Path to your oh-my-zsh installation.
export ZSH="/home/mono/.oh-my-zsh"
### spark
# export SPARK_HOME=/opt/spark
# export PATH=$SPARK_HOME/bin:$PATH
# export PYSPARK_DRIVER_PYTHON=jupyter
# export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
# dotnet 
# Add .NET Core SDK tools
export PATH=$HOME/.dotnet/tools:$PATH

### go
# export PATH=$PATH:/usr/local/go/bin
# export GOPATH=$HOME/.go/bin

### ruby
# export PATH=$HOME/.rbenv/bin:$PATH
# eval "$(rbenv init -)"
# export PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH

# java
# export PATH="/home/mono/.jdks/openjdk-15.0.1/bin":$PATH
export JAVA_HOME="/usr/lib/jvm/java-19-openjdk"

export ANDROID_SDK=/home/mono/Android/Sdk/
export ANDROID_HOME=/home/mono/Android/Sdk/
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH

# cd /mnt/D_partition/Download/Dev/React-Projects/a-star

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#  ZSH_THEME="random"
ZSH_THEME="robbyrussell"
# ZSH_THEME="kolo"
# ZSH_THEME="awesomepanda"
#  ZSH_THEME="pmcgee"
#  ZSH_THEME="jispwoso"
#  ZSH_THEME="amuse"
#  ZSH_THEME="amusemod"
#  ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel9k/powerlevel9k"
# ZSH_THEME="myTheme"
# ZSH_THEME="my"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
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
# DISABLE_MAGIC_FUNCTIONS=true

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	vi-mode
	colored-man-pages
	nvm
	command-not-found
	zsh-syntax-highlighting
	history-substring-search
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
# User configuration
# source ~/Dev/other/.conf.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

 
# Example aliases
# alias code="codium"
alias v="nvim"
alias vim=nvim
alias nvimconf="cd .config/nvim && nvim . && cd"
alias vsconfig="code ~/.zshrc"
alias config="v ~/.zshrc"
alias zshconf="v ~/.zshrc"
alias ohmyzsh="v ~/.oh-my-zsh"
# for dotfiles
alias dotconf='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# run this : dotconf config --local status.showUntrackedFiles no 

alias xampp="sudo /opt/lampp/xampp"
alias androidStudio="cd /mnt/D_partition/Download/Dev/android-studio-ide-193\ 6626763-linux/android-studio/bin && ./studio.sh"
# alias emulator=$ANDROID_SDK/tools/emulator
# emulator  @Pixel_2_API_29 
alias vsc="code ."
# mkfile() { mkdir -p -- "$1" && touch -- "$1"/"$2" }
# dev() {
# 	echo "$1 $2 $3"
# 	if [ $1 ] && [ $1 = "now" ];then
# 		echo "starting..."
# 		/mnt/D_partition/Download/Dev/other/on_start.sh $2 $3 
# 		# > /dev/null
# 	else
# 		cd "/mnt/D_partition/Download/Dev/"$1;
# 	fi
# }
	# does the same as alias dev="cd /mnt/D_partition/Download/Dev"
	# with an arg ex: dev react or dev now to launch script 
# alias wifi='nmcli c up id "Gnet-309650"'
alias vpnc='protonvpn-cli connect -f'
alias c='protonvpn-cli connect -f'
alias vpnd='protonvpn-cli disconnect'
alias d='protonvpn-cli disconnect'
# alias androidDebug='/mnt/D_partition/Download/Dev/other/betterScrcpy.sh'
# alias overWifi='/mnt/D_partition/Download/Dev/other/overWifi.sh'
# alias todo='vim Dev/other/todo.md'
# alias godot='"/mnt/D_partition/Download/Dev/GameDev/Godot/Godot.64" --path . --position 9999,9999'
GODOT="/mnt/D/Dev/GameDev/Godot_v4.1.1-stable_mono_linux_x86_64/Godot_v4.1.1-stable_mono_linux.x86_64"
alias disk="gdu"
alias top="htop"
alias restart_plasma="kquitapp5 plasmashell && kstart5 plasmashell"
alias dev="cd /mnt/D/Dev"
alias blur="cd /mnt/D/Dev/GameDev/BlurSecond && nvim . --listen ./godothost"

#welcome msg
# quotes-cli | cowthink -f tux | lolcat
#quotes-cli | cowthink -f tux | lolcat
# fortune -s | cowthink -f tux 
# cat /home/mono/Dev/other/todo.md | lolcat
#fix display
# xrandr --output eDP-1 --set "scaling mode" "Full" 

# vim mode
VI_MODE_SET_CURSOR=true

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fm6000 -r -c random

# pnpm
# export PNPM_HOME="/home/mono/.local/share/pnpm"
# export PATH="$PNPM_HOME:$PATH"
# pnpm end
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
  items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

changeWorkTree(){
  selected=`git worktree list | fzf | cut -d' ' -f1`
  cd $selected
}
alias gw=changeWorkTree

