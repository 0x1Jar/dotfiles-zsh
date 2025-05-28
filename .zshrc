# History control
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=2000000
setopt APPEND_HISTORY

# Zsh has its own completion system, usually initialized with compinit
# if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#     . /etc/bash_completion
# fi

alias grep='grep --color=auto'
alias tnn="cd ~/src/github.com/tomnomnom"
alias :q="exit"
alias follow="tail -f -n +1"

# COLOURS! YAAAY!
export TERM=xterm-256color

# Obviously.
export EDITOR=/usr/bin/vim

# Personal binaries
export PATH=${PATH}:~/bin:~/.local/bin:~/etc/scripts

# I'd quite like for Go to work please.
export PATH=${PATH}:/usr/local/go/bin
export GOPATH=~

# Initialize Zsh completion system
autoload -Uz compinit && compinit

# Open all modified files in vim tabs
function vimod {
    vim -p $(git status -suall | awk '{print $2}')
}

# Open files modified in a git commit in vim tabs; defaults to HEAD. Pop it in your .bashrc
# Examples: 
#     virev 49808d5
#     virev HEAD~3
function virev {
    commit=$1
    if [ -z "${commit}" ]; then
      commit="HEAD"
    fi
    rootdir=$(git rev-parse --show-toplevel)
    sourceFiles=$(git show --name-only --pretty="format:" ${commit} | grep -v '^$')
    toOpen=""
    for file in ${sourceFiles}; do
      file="${rootdir}/${file}"
      if [ -e "${file}" ]; then
        toOpen="${toOpen} ${file}"
      fi
    done
    if [ -z "${toOpen}" ]; then
      echo "No files were modified in ${commit}"
      return 1
    fi
    vim -p ${toOpen}
}

# source ~/etc/git-prompt.sh
# 'Safe' version of __git_ps1 to avoid errors on systems that don't have it
# function gitPrompt {
#   command -v __git_ps1 > /dev/null && __git_ps1 " (%s)"
# }

# Add git info to prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a)'
zstyle ':vcs_info:*' enable git # SCMs to support

# Colours
txtgrn='%{\e[0;32m%}' # Green
txtpur='%{\e[0;35m%}' # Purple
txtwht='%{\e[0;37m%}' # White

# Prompt colours
atC="${txtpur}"
nameC="${txtpur}"
hostC="${txtpur}"
pathC="${txtgrn}"
gitC="${txtpur}"
pointerC="${txtgrn}"
normalC="${txtwht}"

# Patent Pending Prompt
# Zsh prompt: %n (username), %m (hostname), %~ (cwd)
setopt PROMPT_SUBST
export PS1="${nameC}%n${atC}@${hostC}%m:${pathC}%~${gitC}\${vcs_info_msg_0_}${pointerC}▶${normalC} "

# Settings equivalent to .inputrc
# ---------------------------------

# 1. Prefix history search (Up/Down arrows)
# Requires history-substring-search widget
autoload -U history-substring-search
zle -N history-substring-search-up
zle -N history-substring-search-down
bindkey '\e[A' history-substring-search-up    # Up arrow for history substring search
bindkey '\e[B' history-substring-search-down  # Down arrow for history substring search

# 2. Completion settings
# Show all completions if ambiguous (similar to show-all-if-ambiguous on)
setopt AUTO_LIST
# Ignore case in completion
# This makes completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 3. Shortcut for cd .. (Ctrl-N)
up-directory-and-execute() {
  # Saves current buffer, sets new command "cd ..", and executes it
  zle push-input
  BUFFER="cd .."
  zle accept-line
}
zle -N up-directory-and-execute
bindkey '^N' up-directory-and-execute

# ---------------------------------
# End of .inputrc equivalent settings

# Local settings go last
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
