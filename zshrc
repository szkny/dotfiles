## measure zshrc startup time
# zmodload zsh/zprof

## cargo setup
[ -f ~/.cargo/env ] && source ~/.cargo/env

## sheldon
eval "$(sheldon source)"

## starship
eval "$(starship init zsh)"

## zoxide
eval "$(zoxide init zsh)"

## 補完機能
setopt ALWAYS_TO_END 
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' complete-options true
zstyle ':completion:*:options' auto-description '%d'

## Vim風キーバインド
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^U" kill-whole-line
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history

## Emacs風キーバインド
# bindkey -e

## cdとタイプしなくても、移動
setopt AUTO_CD

## cdの履歴を保持（同一のディレクトリは重複排除）
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

## command history
setopt share_history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

## alias for commands
alias cd='cdls'
alias ls='eza -G --icons'
alias ll='eza -lh --icons'
alias c='clear'
alias tree='eza -T --icons'
alias mv='mv -i'
alias od='od -x'
alias rsync='rsync -auvrz'
alias kill='kill -9'
alias g='git'
alias gcam='git commit -am'
alias gp='git pull'
alias lg='lazygit'
alias gg='lazygit'
alias drop_caches="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches'\""
alias ssh-select='ssh "$(grep -E "^Host " ~/.ssh/config | awk "{print \$2}" | fzf --height=40% --reverse --prompt="Select SSH Host: ")"'

## setup for vim
export EDITOR='nvim'
alias vi="$EDITOR"
alias vin="$EDITOR --noplugin"
alias vimdiff="$EDITOR -d"
alias vide="$EDITOR -S ~/.config/nvim/ide.vim"
alias vimrc="$EDITOR ~/dotfiles/nvim/init.vim ~/dotfiles/nvim/vimrc/*.vim"
alias nvimrc="$EDITOR ~/dotfiles/todo.md ~/dotfiles/nvim/init.lua ~/dotfiles/nvim/lua/*.lua"
alias weztermconf="$EDITOR ~/dotfiles/wezterm.lua && cp ~/dotfiles/wezterm.lua ~/win_home/.wezterm.lua"
alias alacrittyconf="$EDITOR  ~/dotfiles/alacritty.yml && cp ~/dotfiles/alacritty.yml ~/win_home/AppData/Roaming/alacritty/alacritty.yml"
alias zshrc="$EDITOR ~/.zshrc;source ~/.zshrc"
alias zprofile="$EDITOR ~/.zprofile;source ~/.zprofile"

## alias for mac
# alias mdfind='mdfind -onlyin'
# alias updatedb='sudo /usr/libexec/locate.updatedb'
alias ql='qlmanage -p "$@" >& /dev/null'
# alias cpwd='pwd;pwd|pbcopy'

## misc
alias trans='trans -brief'
alias trans_ja='trans -brief -from=ja -to=en'
alias trans_en='trans -brief -from=en -to=ja'
alias jupyterlab='\cd ~/Project/jupyterlab && jupyter lab'
alias iipython='ipython --profile=iterm2 --no-confirm-exit'

## binds
bindkey -s '^V' '^uvi\n'
bindkey -s '^H' '^uranger-cd\n'
# bindkey -s '^H' '^ucd **\t'
bindkey -s '^F' '^ufdghq\n'
bindkey -s '^G' '^uzg\n'

## functions
function fzf-command-widget() {
  if [[ -z "$LBUFFER" ]]; then
    local cmd=$(compgen -c | sort | uniq | fzf --height 40% --reverse)
    if [[ -n $cmd ]]; then
      LBUFFER+="$cmd "
    fi
    zle redisplay
  else
    zle expand-or-complete
  fi
  return 0
}
zle -N fzf-command-widget
bindkey '^I' fzf-command-widget

# function fzf-history-widget() {
#   local selected_command=$(history -n 0 | tac | uniq | fzf --height 40% --reverse | sed 's/ *[0-9]* *//')
#   if [[ -n $selected_command ]]; then
#     LBUFFER="$LBUFFER$selected_command"
#     zle reset-prompt
#   fi
#   return 0
# }
# zle -N fzf-history-widget
# bindkey '^R' fzf-history-widget

function cdls(){
  \cd $@ && [ $( ls | wc -l ) -lt 20 ] && eza -G --icons
  return 0
}

function checked_git_pull () {
  echo
  echo -n "run 'git pull'? [y/N]: "
  if read -q; then
    echo
    git pull
  fi
}

function ranger-cd(){
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    echo -en "\033[1A\033[2K\033[1A\033[2K"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

function kill_process() {
    selected=$(ps -e -o pid,user,comm --sort=-%cpu | fzf --header="Select processes to kill (Tab to select multiple)" --ansi --multi --header-lines=1)
    if [[ -z "$selected" ]]; then
        echo "No process selected."
        return 0
    fi
    echo "Kill the following processes? [y/N]"
    echo "$selected"
    if read -q; then
        echo
        pids=$(echo "$selected" | awk '{print $1}')
        for pid in ${(f)pids}; do
            kill "$pid" && echo "Process $pid killed." || echo "Failed to kill process $pid."
        done
    else
        echo "Operation canceled."
    fi
}

function google() { # Goolge Search by Google Chrome
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            # $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
            str="$str${str:++}$i"
        done
        opt='search?num=100'
        opt="${opt}&q=${str}"
    fi
    open -a Google\ Chrome http://www.google.co.jp/$opt
}

function command_not_found_handler(){
    echo "zsh: command not found: " $1
    echo -e "  __        ___    ____ _____ _____ ____   \n"\
            " \\ \\      / / \\  / ___|_   _| ____|  _ \\  \n"\
            "  \\ \\ /\\ / / _ \\ \\___ \\ | | |  _| | | | | \n"\
            "   \\ V  V / ___ \\ ___) || | | |___| |_| | \n"\
            "    \\_/\_/_/   \\_\\____/ |_| |_____|____/  \n"
}

function jupyterlab-rm-checkpoints(){
    find ~/Project/jupyterlab -name .ipynb_checkpoints
    find ~/Project/jupyterlab -name .ipynb_checkpoints | xargs rm -rf
}

function openiterm(){
    osascript -e 'tell application "Iterm" to activate'
}

function IsExistCmd(){ type "$1" > /dev/null 2>&1; }

function start-tmux(){
  if ! IsExistCmd tmux; then
    echo tmux not installed
    return 1
  fi
  tmux_count=$(ps -ef | grep '[t]mux' | wc -l)
  if [[ $SHLVL -eq 1 && $tmux_count -eq 0 ]]; then
    export TERM="screen-256color"
    tmux -u new-session
  # elif [[ $SHLVL -eq 1 && $tmux_count -gt 1 ]]; then
  #   tmux -u attach
  fi
}

function dotfiles(){
  cd ~/dotfiles
  checked_git_pull
  return 0
}

function zg () {
  local dir=$(zoxide query --list --score | fzf --height 40% --no-sort | sed 's/^\ *[0-9.]\+ //')
  [ "${dir}" != "" ] && cd "${dir}" && [ -d .git ] && checked_git_pull
  return 0
}

## aws cli utility functions
function get-active-ec2-instances() {
    local TMP_AWS_PROFILE=$AWS_PROFILE
    if [ $# -eq 1 ]; then
        export AWS_PROFILE="$1"
    fi
    (
        echo "Name InstanceId PrivateIP LaunchTime"
        echo "---------- ---------- ---------- ----------"
        aws ec2 describe-instances | \
        jq -r '.[][].Instances[] | select(.State.Name=="running") |
            [
                (.Tags[] | select(.Key=="Name").Value),
                .InstanceId,
                .PrivateIpAddress,
                .LaunchTime
            ] | @tsv'
    ) | column -t
    export AWS_PROFILE=$TMP_AWS_PROFILE
    return 0
}
function ssh-active-ec2-instances() {
    local TMP_AWS_PROFILE=$AWS_PROFILE
    if [ $# -eq 1 ]; then
        export AWS_PROFILE="$1"
    fi
    local ACTIVE_INSTANCES=`get-active-ec2-instances $1`
    local SELECTED_INSTANCE=`echo $ACTIVE_INSTANCES | fzf`
    local SSH_TARGET=`echo $SELECTED_INSTANCE | awk '{print $2}'`
    if [ ${#SSH_TARGET} -gt 1 ]; then
        echo " $ sshrc $SSH_TARGET"
        sshrc $SSH_TARGET
    fi
    export AWS_PROFILE=$TMP_AWS_PROFILE
    return 0
}

## fzf function
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
  return 0
}
function fdghq(){
  local selectedrepos=$(ghq list --full-path | fzf)
  if [ -n "$selectedrepos" ]; then
    cd $selectedrepos
    checked_git_pull
  fi
  return 0
}
function fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  return 0
}
function fshow() {
  git log --graph --color=always --date=format:'%Y/%m/%d %H:%M' --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s' |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
              FZF-EOF" \
      --preview "
          echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
          xargs -I % sh -c 'git show --color=always %'
      "
  return 0
}

## language
export LANGUAGE="C.UTF-8"
export LANG=$LANGUAGE
export LC_ALL=$LANGUAGE

## PATHs
export PATH="$PATH:$HOME/Project/bin"

## mise
eval "$(~/.local/bin/mise activate zsh)"

## go setup
export GOPATH=$(mise where go)
export PATH=$PATH:$GOPATH/bin

# ## pyenv setup
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"

# # volta
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"

## terraform setup
export PATH=$PATH:$HOME/.tfenv/bin

## Android dev setup
export ANDROID_SDK_ROOT=$HOME/Project/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

## flutter setup
export PATH=$PATH:$HOME/flutter/bin

## mocword
export MOCWORD_DATA=~/.mocword/mocword.sqlite

# ## ChatGPT
# source "$HOME/.openai_key.zsh"

## X11
export DISPLAY=$(ipconfig.exe | grep -a "IPv4" | tail -1 | awk '{print $NF}' | awk 'sub(/\r$/,"")'):0.0
# export TERM="xterm-256color"

## start tmux
export TERM="screen-256color"
start-tmux

## measure zshrc startup time
# zprof
