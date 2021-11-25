#!/usr/bin/env bash

echo "This script has been tested only on Linux Manjaro Gnome."
echo "Note: Before Running the script restore your gpg and ssh keys!"
echo "Note: I think this needs sudo permission!"

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
pamac update -a

PKGS=(
  # 'neovim'
  'nodejs'
  'htop'
  'figlet'
  'tmux'
  'docker'
  'awesome-terminal-fonts'
  'kitty'
  'alacritty'
  'yajl'
  'ctags'
  'cmake'
  'rust'
  # 'cpanminus'
  # 'python2'
  'pamixer'
  'nitrogen'
  'conky-i3'
  'i3exit'
  'i3-help'
  'i3-scripts'
  'volumeicon'
  'i3-scrot'
  'clipit'
  'copyq'
  'pcmanfm'
  'dunst'
  'python-pip'
  'yay'
  'base-devel'
)

echo
echo "Installing Some repository packages that would be needed in anywhere of my setup"

for PKG in "${PKGS[@]}"; do
  echo
  echo "INSTALLING: ${PKG} with all of its optional dependencies."
  sudo pacman -S --noconfirm --needed "$PKG"
  sudo pacman -S --noconfirm --asdeps --needed $(pacman -Si "$PKG" | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt.*://g' | sed 's/^\s*//g' | tr '\n' ' ')
done

echo
echo "INSTALLING brave-browser not all of its dependencies."
sudo pacman -S --noconfirm --needed brave-browser
sudo pacman -S --noconfirm --asdeps --needed cups libgnome-keyring

echo
echo "INSTALLING global not all of its dependencies."
sudo pacman -S --noconfirm --needed global
sudo pacman -S --noconfirm --asdeps --needed ctags python-pygments vim emacs

echo
echo "INSTALLING i3-gaps not all of its dependencies."
sudo pacman -S --noconfirm --needed i3-gaps
sudo pacman -S --noconfirm --asdeps --needed i3lock i3status-manjaro perl-json-xs perl-anyevent-i3

echo
echo "INSTALLING morc_menu not all of its dependencies."
sudo pacman -S --noconfirm --needed morc_menu
sudo pacman -S --noconfirm --asdeps --needed wmutils xdotool rootmenu

AUR_PKGS=(
  'xdman'
  'picom-jonaburg-git'
  'tmuxinator'
  'ruby-colorls'
  'ruby-neovim'
  'polybar-dwm-module'
  'log4cxx-git' # at the momment ros-melodic works with this version of log4xx
  'ttf-blex-nerd-font-git'
  'nerd-fonts-ubuntu-mono'
  'mocp-scrobbler'
  'mocp-themes-git'
  'nerd-fonts-jetbrains-mono'
  'zorin-desktop-themes'
)

echo
echo "Installing Some AUR packages that would be needed in anywhere of my setup"

for AUR_PKG in "${AUR_PKGS[@]}"; do
  echo
  echo "Building and Installing: ${AUR_PKG}"
  yay -S --noconfirm --needed "$AUR_PKG"
  yay -S --noconfirm --asdeps --needed $(yay -Si "$AUR_PKG" | sed -n '/^Opt/,/^Conf/p' | sed '$d' | sed 's/^Opt.*://g' | sed 's/^\s*//g' | tr '\n' ' ')
done

echo
echo "Copying configuration files and installing special packages:"

echo
echo "setup tmux"
if [ -f "$HOME/.tmux.conf" ]; then
  mv $HOME/.tmux.conf $HOME/.tmux.conf.backup
fi
cp $_cwd/.tmux.conf $HOME
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo
echo "Install tmux plugins by pressing prefix+I in a tmux session."

echo
echo "Copying kitty configs"
if [ -d "$HOME/.config/kitty" ]; then
  mv $HOME/.config/kitty $HOME/.config/kitty.backup
fi
cp -r $_cwd/.config/kitty ~/.config

echo
echo "Copying picom configs"
if [ -f "$HOME/.config/picom.conf" ]; then
  mv $HOME/.config/picom.conf $HOME/.config/picom.conf.backup
fi
cp $_cwd/.config/picom.conf.jonaburg ~/.config/picom.conf

echo
echo "Copying colorls configs"
if [ -d "$HOME/.config/colorls" ]; then
  mv $HOME/.config/colorls $HOME/.config/colorls.backup
fi
cp -r $_cwd/.config/colorls ~/.config

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
cp $_cwd/.zshrc $HOME
cp $_cwd/.Xresources $HOME

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion

echo
echo "Copying i3 window manager configs"
if [ -d "$HOME/.i3" ]; then
  mv $HOME/.i3 $HOME/.i3.backup
fi
mkdir $HOME/.i3
cp $_cwd/.i3/config $HOME/.i3/
cp $_cwd/.config/dunst/dunstrc $HOME/.config/

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

mkdir $HOME/ManBuild_Packs
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
git clone https://github.com/amirrezasadeqi/nvim_configs.git $HOME/.config/nvim
echo
echo "installing somethings for more oks in checkhealth!"
sudo npm install -g neovim
sudo cpanm -n Neovim::Ext
sudo cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5 -Mlocal::lib)
pip install pynvim
echo
echo "update remote plugins and install plugins in the first neovim run."
echo "Neovim Nightly is in your service!"

echo
echo "Build and config dmenu"
cd $HOME/ManBuild_Packs
git clone https://gitlab.com/e.a.sadeqi/dmenu-distrotube.git
cd $HOME/ManBuild_Packs/dmenu-distrotube
git checkout asModification
sudo make install
echo "dmenu is ready"

echo
echo "Build and config st terminal"
cd $HOME/ManBuild_Packs
git clone https://github.com/amirrezasadeqi/st.git
cd $HOME/ManBuild_Packs/st
git checkout asModification
sudo make install
echo "st is ready"

echo
echo "Build and config dwm"
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
mkdir $HOME/.dwm
cp $HOME/ManBuild_Packs/dwm/.dwm/autostart.sh $HOME/.dwm 
cp $HOME/ManBuild_Packs/dwm/.dwm/bar.sh $HOME/.dwm
cp $HOME/ManBuild_Packs/dwm/.dwm/config $HOME/.dwm
if [ -f "/usr/bin/blurlock" ]; then
  sudo rm /usr/bin/blurlock
fi
sudo cp $HOME/ManBuild_Packs/dwm/.dwm/blurlock /usr/bin
sudo cp $HOME/ManBuild_Packs/dwm/.dwm/sysact /usr/bin
sudo cp $HOME/ManBuild_Packs/dwm/.dwm/dwm.desktop /usr/share/xsessions/dwm.desktop
cd $HOME/ManBuild_Packs
git clone https://github.com/LukeSmithxyz/voidrice.git
cd $HOME/ManBuild_Packs/voidrice
sudo cp -r -n -v $HOME/ManBuild_Packs/voidrice/.local/bin/* /usr/bin/
sudo touch /etc/X11/xorg.conf.d/30-touchpad.conf
cat << EOF >> /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad catchall"
    Driver "libinput"
    Option "Tapping" "on"
EndSection
EOF

echo
echo "installing some nice dynamic wallpapers"
if [ -d "/usr/share/backgrounds/Dynamic_Wallpapers" ]; then
  sudo rm -r /usr/share/backgrounds/Dynamic_Wallpapers
fi
cd $HOME/ManBuild_Packs
git clone https://github.com/saint-13/Linux_Dynamic_Wallpapers.git
cd $HOME/ManBuild_Packs/Linux_Dynamic_Wallpapers
sudo bash ./install.sh


echo
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
echo -n "Reboot? [Y|n] "
read yn
yn=${yn:-y}
if [ "$yn" != "y" ]; then
  echo "please reboot"
  exit
fi

reboot
