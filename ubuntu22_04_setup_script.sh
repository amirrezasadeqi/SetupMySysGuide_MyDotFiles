#!/usr/bin/env bash

echo "This script has been tested only on Ubuntu 22.04 LTS."

echo
echo -n "Should we start? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  echo "aborting script!"
  exit
fi

_cwd="$(pwd)"

echo
echo "Updating the System"
sudo apt-get update
echo

echo "Installing packages..."
echo 
sudo apt-get install build-essential python3 python3-pip python3-neovim libevent-dev ruby-dev htop tmux tmuxinator global universal-ctags cscope emacs nodejs npm zsh openconnect network-manager-openconnect-gnome git make ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen kitty libyajl-dev lldb gdb nitrogen ranger clipit copyq dunst vim volumeicon-alsa pamix ripgrep fd-find fzf bison strace libncurses-dev xdotool i3 i3blocks conky stow unzip wget libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev libxft-dev libxinerama-dev libharfbuzz-dev

echo
echo "Installing fzf ..."
echo 
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
echo 

echo "Setup npm based on lunarvim setup ..."
echo 
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile

echo 
echo "Installing rust ... "
echo 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo

echo 
echo "Installing colorls..."
echo 
sudo gem install colorls
echo 

echo "[-] Download fonts [-]"
echo "JetBrains nerd fonts..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip
sudo unzip JetBrainsMono.zip -d /usr/local/share/fonts
rm JetBrainsMono.zip
echo
echo "Blex Mono nerd fonts..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/IBMPlexMono.zip
sudo unzip IBMPlexMono.zip -d /usr/local/share/fonts
rm IBMPlexMono.zip
echo 
fc-cache -fv
echo "done!"

echo
echo "Installing DOOM emacs"
echo
if [ -d "$HOME/.emacs.d" ]; then
  mv $HOME/.emacs.d $HOME/.emacs.d.backup
fi
git clone --depth 1 https://github.com/hlissner/doom-emacs $HOME/.emacs.d
echo
echo "Run bellow command to install complete. Not tested yet so was commented."
echo "~/.emacs.d/bin/doom install"
echo "In future you should copy your custom configurations in this point."
echo

echo
echo "Copying configuration files and installing special packages:"
cp -r Machfiles ~

echo
echo "setup tmux"
if [ -f "$HOME/.tmux.conf" ]; then
  mv $HOME/.tmux.conf $HOME/.tmux.conf.backup
fi
stow -d ~/Machfiles tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo
echo "Install tmux plugins by pressing prefix+I in a tmux session."
echo

mkdir $HOME/ManBuild_Packs

echo
echo "Copying kitty configs"
if [ -d "$HOME/.config/kitty" ]; then
  mv $HOME/.config/kitty $HOME/.config/kitty.backup
fi
stow -d ~/Machfiles kitty
echo "cloning kitty themes"
#git clone --depth 1 git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
cd $HOME/ManBuild_Packs
wget https://github.com/dexpota/kitty-themes/archive/refs/heads/master.zip
unzip master.zip
rm master.zip
mv kitty-themes-master $HOME/.config/kitty/kitty-themes
echo
#ln -s ~/.config/kitty/kitty-themes/themes/Dracula.conf ~/.config/kitty/theme.conf
echo
echo "kitty is at your service."

echo
echo "Installing alacritty."
echo 
cd $HOME/ManBuild_Packs
git clone https://github.com/alacritty/alacritty.git
cd alacritty
sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
echo "Copying alacritty configs"
if [ -d "$HOME/.config/alacritty" ]; then
  mv $HOME/.config/alacritty $HOME/.config/alacritty.backup
fi
stow -d ~/Machfiles alacritty
echo "cloning alacritty themes"
echo
git clone https://github.com/eendroroy/alacritty-theme.git $HOME/.config/alacritty/theme_collection
echo
echo "alacritty is at your service."

echo
echo "Setup ZSH"
echo "Installing oh-my-zsh"
echo

# based on the oh my zsh repository readme file using --unattended flag does not cause exiting the main install script.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo
echo "you must change your shell after this script by running bellow command:"
echo "chsh -s \$(which zsh)"   
echo "logout and log back then to have zsh."
echo

if [ -f "$HOME/.zshrc" ]; then
  mv $HOME/.zshrc $HOME/.zshrc.backup
fi
if [ -f "$HOME/.Xresources" ]; then
  mv $HOME/.Xresources $HOME/.Xresources.backup
fi
stow -d ~/Machfiles zsh
stow -d ~/Machfiles Xresources

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion

echo
echo "Copying colorls configs"
if [ -d "$HOME/.config/colorls" ]; then
  mv $HOME/.config/colorls $HOME/.config/colorls.backup
fi
stow -d ~/Machfiles colorls
echo

echo
echo "Copying i3 window manager configs"
if [ -d "$HOME/.i3" ]; then
  mv $HOME/.i3 $HOME/.i3.backup
fi
stow -d ~/Machfiles i3
stow -d ~/Machfiles dunst

echo
echo "Setup git"
git config --global user.name "amirrezasadeqi" 
git config --global user.email "e.a.sadeqi@gmail.com" 
git config --global core.editor nvim
git config --global commit.gpgsign true
git config --global credential.helper libsecret
export GPG_TTY=$(tty)
echo
echo "You Must Set the default signing key for you commits by running:"
echo "git config --global user.signingkey <your generated gpg key>"
echo "you can find your gpg key by running bellow command:"
echo "gpg --list-secret-keys --keyid-format=long"

echo
echo "Building Customized or specific packages"
echo "Building neovim nightly edition"
cd $HOME/ManBuild_Packs
git clone https://github.com/neovim/neovim.git
cd $HOME/ManBuild_Packs/neovim
git checkout nightly
make -j 8 CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/ManBuild_Packs/neovim"
make install
echo
echo "The path of this neovim installation is exported at the end of your .zshrc file!"
echo "otherwise add bellow command to your rc file:"
echo "export PATH=\"\$HOME/path/to/neovim/nightly/bin:\$PATH\""
echo "Copying neovim configs"
echo
if [ -d "$HOME/.config/nvim" ]; then
  mv $HOME/.config/nvim $HOME/.config/nvim.backup
fi
git clone --branch plua https://github.com/amirrezasadeqi/nvim_configs.git $HOME/.config/nvim
echo
echo "installing somethings for more oks in checkhealth!"
sudo npm install -g neovim
pip install pynvim
echo
echo "update remote plugins and install plugins in the first neovim run."
echo "Neovim Nightly is in your service!"

echo
echo "Build and config dmenu"
read -p "You may need to turn on your VPN for cloning from gitlab. If you are OK, Press enter to continue"
cd $HOME/ManBuild_Packs
git clone https://gitlab.com/e.a.sadeqi/dmenu-distrotube.git
cd $HOME/ManBuild_Packs/dmenu-distrotube
git checkout asModification
sudo make install
echo
echo "dmenu is ready"
read -p "Now you can turn off your VPN for faster download. If you are OK, Press enter to continue"

echo
echo "Build and config st terminal"
cd $HOME/ManBuild_Packs
git clone https://github.com/amirrezasadeqi/st.git
cd $HOME/ManBuild_Packs/st
git checkout asModification
sudo make install
echo "st is ready"

echo
echo "Build and config jonaburg picom"
echo 
cd $HOME/ManBuild_Packs
git clone https://github.com/jonaburg/picom
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
echo
echo "Copying picom configs"
if [ -f "$HOME/.config/picom.conf" ]; then
  mv $HOME/.config/picom.conf $HOME/.config/picom.conf.backup
fi
stow -d ~/Machfiles picom
echo

echo
echo "Build and config polybar"
echo 
cd $HOME/ManBuild_Packs
git clone https://github.com/mihirlad55/polybar-dwm-module
cd polybar-dwm-module
./build.sh -d
echo

echo
echo "Build and config dwm"
sudo apt-get install libx11-dev libxinerama-dev libxft-dev libx11-xcb-dev libxcb-res0-dev
cd $HOME/ManBuild_Packs
git clone https://github.com/amirrezasadeqi/dwm.git
cd dwm
git checkout asModification
sudo make install
echo
echo "Copying dwm configs"
if [ -d "$HOME/.dwm" ]; then
  mv $HOME/.dwm $HOME/.dwm.backup
fi
stow -d ~/Machfiles dwm
if [ -f "/usr/bin/blurlock" ]; then
  sudo rm /usr/bin/blurlock
fi
sudo stow -d ~/Machfiles -t /usr usr_files
stow -d ~/Machfiles local

if [ -f "$HOME/.ideavimrc" ]; then
  mv ~/.ideavimrc ~/.ideavimrc.backup
fi
stow -d ~/Machfiles ideavim

sudo touch /etc/X11/xorg.conf.d/30-touchpad.conf
sudo bash -c 'cat << EOF >> /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad catchall"
    Driver "libinput"
    Option "Tapping" "on"
EndSection
EOF'

echo "Now System is ready. just be sure you do bellow things if you did not:"
echo "Install tmux plugins by pressing prefix+I in a tmux session."
echo "You Must Set the default signing key for you commits by running:"
echo "git config --global user.signingkey <your generated gpg key>"
echo "you can find your gpg key by running bellow command:"
echo "gpg --list-secret-keys --keyid-format=long"
echo "The path of this neovim installation is exported at the end of your .zshrc file!"
echo "otherwise add bellow command to your rc file:"
echo "export PATH=\"\$HOME/path/to/neovim/nightly/bin:\$PATH\""
echo "update remote plugins and install plugins in the first neovim run."

echo
echo "you must change your shell after this script by running bellow command:"
echo "chsh -s \$(which zsh)"   
echo "logout and log back then to have zsh."
echo

echo
echo -n "Reboot? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  echo "please reboot"
  exit
fi

reboot

