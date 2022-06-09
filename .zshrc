# make vim properky detect 256 colors
export TERM=screen-256color

# exec tmux when the terminal is opend
if [ $SHLVL = 1 ]; then
  tmux
fi

# environment variable
export LANG=ja_JP.UTF-8

# the setting of the history command
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# delete a command history which is identical to the previous one
setopt hist_ignore_dups
setopt hist_ignore_all_dups

# enable zsh to share command history with each of its session
setopt share_history

# aoto completion
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt list_packed
autoload colors
zstyle ':completion:*' list-colors ''

# fix commands' misspelling
setopt correct

# no beep
setopt no_beep

# directory stack
DIRSTACKSIZE=100
setopt AUTO_PUSHD

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# prompt custum
PROMPT='
[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

# delete all containers and delete all images
alias docker-prune='docker container stop $(docker container ls -aq) ; docker container rm -f $(docker container ls -aq) ; docker image rm -f $(docker image ls -aq) ; docker volume rm -f $(docker volume ls -q) ; docker network rm $(docker network ls -q)'

# open Chrome without the CORS Policy
alias chrome-nocors='open /Applications/Google\ Chrome.app --args --user-data-dir="/var/tmp/Chrome dev session" --disable-web-security'

# create a directory and switch the current directory to it
md () {
  mkdir $1
  cd $1
}

# delete all python libraries managed by pip3
alias python-prune='pip3 uninstall -y -r <(pip3 freeze)'

# unistall command
uninstall () {
  spt play --uri spotify:track:0UaQPu8dlcZfzg9g7DUSkD
  sleep 68
  rm "$@"
}

# capy
capy () {
  cat "$@" | pbcopy
}

# golang
export GO111MODULE=on
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=/Users/$USER/src/go

# increase the default number of history entries displayed
alias history='fc -l -100'

# tmux ide
ide () {
 tmux split-window -v -p 30
 tmux split-window -h -p 66
 tmux split-window -h -p 50
}

# pwd + pbcopy
pwdy () {
  pwd | pbcopy
}

# use vim installed with homebrew
export PATH="/usr/local/bin:$PATH"

# login in the same directory as the last time when exiting
export dirfile="$HOME/.who.$host.$tty"
export dirhfile="$HOME/.who.$host"

if [[ ! -f $dirfile  ]]; then
    if [[ ! -f $dirhfile  ]]; then
        dir=$HOME
    else
        dir=`cat $dirhfile`
    fi
else
    dir=`cat $dirfile`
    if [[ -d $dir  ]]; then
        cd $dir
    else
        dir=$HOME
    fi
fi

function pushd {
    builtin pushd "$@"
    echo $PWD > $dirfile
    echo $PWD > $dirhfile

}

function popd {
    builtin popd "$@"
    echo $PWD > $dirfile
    echo $PWD > $dirhfile

}

function cd {
    builtin cd "$@"
    echo $PWD > $dirfile
    echo $PWD > $dirhfile

}
