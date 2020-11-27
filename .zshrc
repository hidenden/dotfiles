bindkey -e

#### golang environment
## export GOPATH=$(go env GOPATH)
## export GOROOT=$(go env GOROOT)

#### PATH setting
export PATH="$PATH:/usr/sbin:/sbin"
export PATH="/usr/local/bin:$PATH"
## export PATH="/Applications/Emacs.app/Contents/MacOS/bin":$PATH
export PATH="$HOME/bin:$PATH"
## export PATH=$PATH:"/Users/hide/Library/Python/3.7/bin"
## export PATH="/Users/hide/Library/Python/3.7/bin:$PATH"
## export PATH="/usr/local/go/bin:$PATH"
## export PATH="$(go env GOPATH)/bin:$PATH"

#### Environment
export PAGER="less"
export RSYNC_RSH=ssh
export LC_ALL=en_US.UTF-8
#export LC_COLLATE=C
#export LC_TIME=C
#export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8
export LESSCHARSET=utf-8
export VISUAL=/usr/bin/vim
export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad

#### Aliases
alias ls='ls -vF'
alias sux='sudo /bin/zsh'
alias ssh-add="ssh-add $HOME/.ssh/id_dsa"

#### zsh options ######################
setopt ignore_eof
setopt notify

setopt correct

setopt pushdtohome
setopt cdablevars
setopt autolist

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

setopt recexact
setopt longlistjobs 
setopt histignoredups 
setopt pushdsilent 
#unsetopt correctall

setopt print_eight_bit

autoload -U promptinit 
promptinit
prompt suse

autoload -Uz colors
colors

autoload -Uz compinit
compinit



#####################
#  rbenv
######################################
## export PATH="/Users/hide/.rbenv/shims:${PATH}"
## export RBENV_SHELL=zsh
# source '/usr/local/Cellar/rbenv/1.1.1/libexec/../completions/rbenv.zsh'
## command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
######################################

###########################
#  nodenv
## export PATH="$HOME/.nodenv/bin:$PATH"
## eval "$(nodenv init -)"

##################################
#  Tensorflow
function tensor_active(){
  . ~/dev/venv/tensorflow_macos_venv/bin/activate
}



