# active# If you come from bash you might have to change your $PATH.
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mono/.oh-my-zsh"
	# spark
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
# dotnet 
export PATH=$HOME/.dotnet/tools:$PATH
# java
# export PATH="/home/mono/.jdks/openjdk-15.0.1/bin":$PATH

export ANDROID_SDK=/mnt/D_partition/Download/Dev/android-sdk/sdk
export PATH=$ANDROID_SDK/emulator:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools:$PATH
export BW_SESSION="b11AtupzoYAH0SSieDrOmaEAIaUjzznoyvT7Lza6dtFbvkaXhckAu3ou0Q4ZCMU4PKOlLKAUkySnL0RTI5WOcw=="
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
#  ZSH_THEME="agnoster"
# ZSH_THEME="powerlevel9k/powerlevel9k"
# ZSH_THEME="myTheme"


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
	# nvm
	command-not-found
	zsh-syntax-highlighting
  zsh-autosuggestions
	history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Example aliases
alias zshconf="vim ~/.zshrc"
alias config="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
# for dotfiles
alias dotconf='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# run this : dotconf config --local status.showUntrackedFiles no 

alias xampp="sudo /opt/lampp/xampp"
alias androidStudio="cd /mnt/D_partition/Download/Dev/android-studio-ide-193\ 6626763-linux/android-studio/bin && ./studio.sh"
# alias emulator=$ANDROID_SDK/tools/emulator
# emulator  @Pixel_2_API_29 
alias vsc="code ."
mkfile() { mkdir -p -- "$1" && touch -- "$1"/"$2" }
dev() {
	echo "$1 $2 $3"
	if [ $1 ] && [ $1 = "now" ];then
		echo "starting..."
		/mnt/D_partition/Download/Dev/other/on_start.sh $2 $3 
		# > /dev/null
	else
		cd "/mnt/D_partition/Download/Dev/"$1;
	fi
}
	# does the same as alias dev="cd /mnt/D_partition/Download/Dev"
	# with an arg ex: dev react or dev now to launch script 
alias wifi='nmcli c up id "Gnet-309650"'
alias vpnc='sudo protonvpn connect -f'
alias vpnd='sudo protonvpn disconnect'

#welcome msg
quotes-cli | cowthink -f tux | lolcat
# fortune -s | cowthink -f tux | lolcat
#fix display
xrandr --output eDP-1 --set "scaling mode" "Full" 
