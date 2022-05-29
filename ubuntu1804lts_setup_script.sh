#!/usr/bin/env bash

echo "This script has been tested only on Ubuntu 18.04 LTS."


Write Down Bellow tasks codes:
  1. sudo apt-get install python3.8 python3-neovim libevent-dev docker ruby2.6
  ruby-dev htop tmuxinator global emacs npm zsh-syntax-highlighting zsh-theme-powerlevel9k 
  2. git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
     ~/.fzf/install
  3. Install Nerdfonts
  4. sudo gem install colorls
  5. curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
     sudo dpkg -i ripgrep_13.0.0_amd64.deb
  6. Build Tmux from source
     git clone https://github.com/tmux/tmux.git
     cd tmux
     sh autogen.sh
     ./configure && make
     sudo make install
  7. Install fd: sudo dpkg -i fd_8.3.2_amd64.deb  # adapt version number and architecture
  8. Install nodejs from:
     https://github.com/nodejs/help/wiki/Installation#how-to-install-nodejs-via-binary-archive-on-linux
  9. pip3 install pynvim
  10.git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
     git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
     git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
  11. Install exuberant-ctags global cscope

