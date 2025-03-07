## Path
CONFIG_PATH=$HOME/.config
PATH="$HOME/.local/bin:/opt/homebrew/opt/macos-trash/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"

## OMZ
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(git tmux tinted-shell)
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_FIXTERM_WITH_256COLOR=tmux-256color
source $ZSH/oh-my-zsh.sh

## Alias
alias rm='trash'
cd() { builtin cd "$@"; ll; }

update() {
	brew update
	brew upgrade

	vim -E +PluginUpdate +qall

	~/.tmux/plugins/tpm/bin/update_plugins all

	#python3 ~/.vim/bundle/youcompleteme/install.py --clangd-completer --ts-completer --quiet

	omz update

	command rm -f ~/.zcompdump
	compinit
}

keebuild() {
  QMK_PATH=$HOME/.qmk
  KEYMAP_PATH=$QMK_PATH/keyboards/keyboardio/atreus/keymaps/hxelet

  pushd $QMK_PATH
  git pull
  command cp -a $CONFIG_PATH/keymap $KEYMAP_PATH
  docker run --rm -it --privileged -v /dev:/dev -w /qmk_firmware -v $QMK_PATH:/qmk_firmware:z ghcr.io/qmk/qmk_cli make keyboardio/atreus:hxelet
  command rm -rf $KEYMAP_PATH
  command mv $QMK_PATH/*.hex ~/Downloads
  popd
}

keebedit() {
  vi $CONFIG_PATH/keymap
}
