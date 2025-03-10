## Path
CONFIG_PATH=$HOME/.config
PATH="$HOME/.local/bin:$PATH"

## OMZ
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='simple'
plugins=(git tmux tinted-shell)
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_FIXTERM_WITH_256COLOR=tmux-256color
source $ZSH/oh-my-zsh.sh

## Alias
alias rm='trash'
cd() { builtin cd "$@"; ll; }
alias pacman='sudo pacman'
alias svi='sudo vim'
alias systemctl='sudo systemctl'
alias journalctl='sudo journalctl'

update() {
  pacman --noconfirm -Syu
  pacman --noconfirm -Qdtq | ifne sudo pacman -Rns -
  yay -Sua

  vim -E +PluginUpdate +qall

  ~/.tmux/plugins/tpm/bin/update_plugins all

  python ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer --ts-completer --quiet

  omz update
}

keebuild() {
  QMK_PATH=$HOME/.qmk
  KEYMAP_PATH=$QMK_PATH/keyboards/keyboardio/atreus/keymaps/hxelet

  pushd $QMK_PATH
  git pull
  command cp -a $CONFIG_PATH/keymap $KEYMAP_PATH
  sudo qmk flash -kb keyboardio/atreus -km hxelet
  command rm -rf $KEYMAP_PATH
  popd
}

keebedit() {
  vi $CONFIG_PATH/keymap
}

mkvenv() {
  python -m venv $CONFIG_PATH/venv/$1
  source $CONFIG_PATH/venv/$1/bin/activate
}

venv() {
  source $CONFIG_PATH/venv/$1/bin/activate
}

x() {
  echo $(($1))
}
