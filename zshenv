## language
export LANGUAGE="C.UTF-8"
export LANG=$LANGUAGE
export LC_ALL=$LANGUAGE

## cargo setup
[ -f ~/.cargo/env ] && source ~/.cargo/env

## PATHs
export PATH="$PATH:$HOME/Project/bin"

## fzf setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files -uuu --follow --glob "!**/.git/*"'
export FZF_CTRL_T_COMMAND='rg --files -uuu --follow --glob "!**/.git/*"'
export FZF_DEFAULT_OPTS=$(cat <<"EOF"
  --multi
  --height=90%
  --layout=reverse
  --prompt '∷ '
  --pointer 
  --marker 
  --preview '
      [ -f {} ] \
      && bat --color=always --style=numbers {} \
      || eza -T {} -I node_modules
  '
  --preview-window 'hidden,wrap,down,80%'
  --bind 'ctrl-/:toggle-preview,ctrl-j:preview-down,ctrl-k:preview-up'
  --select-1
  --exit-0
EOF
)
export FZF_CTRL_T_OPTS=$(cat <<"EOF"
--preview '
  [ -f {} ] \
  && bat --color=always --style=numbers {} \
  || eza -T {} -I node_modules
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

## mise
eval "$(~/.local/bin/mise activate zsh)"

## go setup
export GOPATH=$(mise where go)
export PATH=$PATH:$GOPATH/bin

## terraform setup
export PATH=$PATH:$HOME/.tfenv/bin

## Android dev setup
export ANDROID_SDK_ROOT=$HOME/Project/Android/sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/build-tools/35.0.0

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

## flutter setup
export PATH=$PATH:$HOME/flutter/bin

## mocword
export MOCWORD_DATA=~/.mocword/mocword.sqlite

## ChatGPT
source "$HOME/.openai_key.zsh"

# ## X11
# export DISPLAY=$(ipconfig.exe | grep -a "IPv4" | tail -1 | awk '{print $NF}' | awk 'sub(/\r$/,"")'):0.0
# # export TERM="xterm-256color"

## start tmux
export TERM="screen-256color"

## for windows PATH
if [ -z "$(echo $PATH | grep '/mnt/c/Windows')" ]; then
    export PATH="$PATH:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0:/mnt/c/ProgramData/chocolatey/bin:/mnt/c/Program Files/WezTerm:/mnt/c/Users/鈴木崇平/AppData/Local/Microsoft/WindowsApps"
fi
