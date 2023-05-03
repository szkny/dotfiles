## measure zshrc startup time
# zmodload zsh/zprof

## sheldon
eval "$(sheldon source)"

## starship
eval "$(starship init zsh)"

## zsh-defer
### tmux
zsh-defer start-tmux
### pyenv
_pyenv_init () { eval "$(pyenv init -)" } && zsh-defer _pyenv_init
### aws-cli
_autocomplete_aws_cli () { complete -C '/usr/local/bin/aws_completer' aws } && zsh-defer _autocomplete_aws_cli

## 補完機能
setopt ALWAYS_TO_END 
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' complete-options true
zstyle ':completion:*:options' auto-description '%d'

## Vim風キーバインド
# bindkey -v
bindkey -e

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
alias ls='exa -G --icons'
alias ll='exa -lh --icons'
alias c='clear'
alias g='git'
alias tree='exa -T --icons'
alias mv='mv -i'
alias od='od -x'
alias rsync='rsync -auvrz'
alias kill='kill -9'
alias gcam='git commit -am'
alias dotfiles='cd ~/dotfiles'

## setup for vim
export EDITOR='nvim'
alias vi="$EDITOR"
alias vin="$EDITOR --noplugin"
alias vimdiff="$EDITOR -d"
alias vide="$EDITOR -S ~/.config/nvim/ide.vim"
alias vimrc="$EDITOR ~/dotfiles/nvim/init.vim ~/dotfiles/nvim/vimrc/*.vim"
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

## functions
function cdls(){
    \cd $@ && exa -G --icons
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
    tmux -u new-session
  # elif [[ $SHLVL -eq 1 && $tmux_count -gt 1 ]]; then
  #   tmux -u attach
  fi
}

## aws cli utility functions
function get-active-ec2-instances() {
    local TMP_AWS_PROFILE=$AWS_PROFILE
    if [ $# -eq 1 ]; then
        AWS_PROFILE="$1"
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
    AWS_PROFILE=$TMP_AWS_PROFILE
}
function ssh-active-ec2-instances() {
    local ACTIVE_INSTANCES=`get-active-ec2-instances $1`
    local SELECTED_INSTANCE=`echo $ACTIVE_INSTANCES | fzf`
    local SSH_TARGET=`echo $SELECTED_INSTANCE | awk '{print $2}'`
    if [ ${#SSH_TARGET} -gt 1 ]; then
        echo " $ sshrc $SSH_TARGET"
        sshrc $SSH_TARGET
    fi
}

## fzf function
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
function fdghq(){
  local selectedrepos=$(ghq list --full-path | fzf)
  if [ -n "$selectedrepos" ]; then
    cd $selectedrepos
    echo
    echo -n "run 'git pull'?(y/N): "
    if read -q; then
      echo
      echo '> git pull'
      git pull
    fi
  fi
}
function fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
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
}

## PATHs
export PATH="$PATH:$HOME/Project/bin"
export PATH="$PATH:$HOME/go/bin"

## fzf setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS=$(cat <<"EOF"
  --multi
  --height=90%
  --layout=reverse
  --preview '
      [ -f {} ] \
      && bat --color=always --style=numbers {} \
      || exa -T {} -I node_modules
  '
  --preview-window 'hidden,wrap,right,90%'
  --bind 'ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up'
  --select-1
  --exit-0
EOF
)
export FZF_CTRL_T_OPTS=$(cat <<"EOF"
--preview '
  [ -f {} ] \
  && bat --color=always --style=numbers {} \
  || exa -T {} -I node_modules
' 
EOF
)
export FZF_CTRL_R_OPTS=$(cat <<"EOF"
  --preview '
    echo {} \
    | awk "{ sub(/\s*[0-9]*?\s*/, \"\"); gsub(/\\\\n/, \"\\n\"); print }" \
    | bat --color=always --language=sh --style=plain
  ' 
  --preview-window 'hidden,wrap,down,3'
EOF
)

## terraform setup
export PATH=$PATH:$HOME/.tfenv/bin

## go setup
export PATH=$PATH:$HOME/go/bin

## pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

## cargo setup
[ -f ~/.cargo/env ] && source ~/.cargo/env

## nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## mocword
export MOCWORD_DATA=~/.mocword/mocword.sqlite

## ChatGPT
source "$HOME/.openai_key.zsh"

## X11
export DISPLAY=$(ipconfig.exe | grep -a "IPv4" | tail -1 | awk '{print $NF}' | awk 'sub(/\r$/,"")'):0.0

## start tmux
export TERM="screen-256color"

## measure zshrc startup time
# zprof
