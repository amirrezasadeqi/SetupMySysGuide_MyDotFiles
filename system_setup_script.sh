#!/usr/bin/env bash

echo "This script has been tested only on Linux Manjaro Gnome."

# It is found a better way to install all optional dependencies for a package
# and in future it will be used for some packages. That way is 'awk' and bellow
# command. This command will list all optional dependencies for a package and
# you can pass it to 'yay -S --asdeps ...' command to install all of them:
# yay -Si <package_name> | awk '/Optional/,/Conflicts/' | awk '$0 !~ /Conflicts/' | awk -F':' 'NR == 1 && NF == 3 {print $(NF-1)};NR == 1 && NF == 2 {print $NF}; NR>1 {print $1}' | awk '{gsub(/ /,"");print}' ORS=" "
# Note that this command is not widely tested but it seems to work well.

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
sudo pacman -Syu
echo
echo "Installing yay"
sudo pacman -S --noconfirm --needed yay

EX_PKGS=(
  # packages from Official repositories.
  # 'neovim'
  'nodejs'
  'htop'
  'docker'
  'kitty'
  'alacritty'
  'figlet'
  'tmux'
  'awesome-terminal-fonts'
  'yajl'
  'ctags'
  'global'
  'cmake'
  'rust'
  'lldb'
  'gdb'
  # 'cpanminus'
  # 'python2'
  'pamixer'
  'nitrogen'
  'volumeicon'
  'pcmanfm'
  'clipit'
  'copyq'
  'dunst'
  'python-pip'
  'base-devel'
  'vim'
  'emacs'
  'i3-gaps'
  'morc_menu'
  'ripgrep'
  'fd'

  # packages from AUR repositories
  'xdman'
  'brave-browser'
  'picom-jonaburg-git'
  'tmuxinator'
  'ruby-colorls'
  'ruby-neovim'
  'polybar-dwm-module' 
  'ttf-unifont'
  'siji-git'
  'xorg-fonts-misc'
  'log4cxx-git' # at the momment ros-melodic works with this version of log4xx
  'ttf-blex-nerd-font-git'
  'nerd-fonts-ubuntu-mono'
  'mocp-scrobbler'
  'mocp-themes-git'
  'nerd-fonts-jetbrains-mono'
  'zorin-desktop-themes'
)

OP_PKGS=(
  'npm'
  'lm_sensors'
  'lsof'
  'strace'
  'btrfs-progs'
  'pigz'
  'imagemagick'
  'libcanberra'
  'ncurses'
  'qt6-base'
  'lightdm-gtk-greeter'
  'xarchiver'
  'dunstify'
  'dbus'
  'xorg-xwininfo'
  'xorg-xprop'
  'python'
  'zsh-completions'
  'cups' 
  'libgnome-keyring'
  'python-pygments'
  'i3lock'
  'i3status-manjaro'
  'perl-json-xs'
  'perl-anyevent-i3'
  'conky-i3'
  'i3exit'
  'i3-help'
  'i3-scripts'
  'i3-scrot'
  'wmutils'
  'xdotool'
  'rootmenu'
)

echo
echo "Installing Explicitly Some packages that would be needed in anywhere of my setup"

for PKG in "${EX_PKGS[@]}"; do
  echo
  echo "INSTALLING Explicitly: ${PKG}"
  yay -S --noconfirm --needed "$PKG"
done

echo
echo "Installing Some packages as optional dependencies for Explicitly installed packages"

for PKG in "${OP_PKGS[@]}"; do
  echo
  echo "INSTALLING Optionally: ${PKG}"
  yay -S --noconfirm --asdeps --needed "$PKG"
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
echo "cloning kitty themes"
git clone --depth 1 git@github.com:dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
echo
ln -s ~/.config/kitty/kitty-themes/themes/Dracula.conf ~/.config/kitty/theme.conf
echo
echo "kitty is at your service."

echo
echo "Copying alacritty configs"
if [ -d "$HOME/.config/alacritty" ]; then
  mv $HOME/.config/alacritty $HOME/.config/alacritty.backup
fi
cp -r $_cwd/.config/alacritty $HOME/.config
echo "cloning alacritty themes"
echo
git clone https://github.com/eendroroy/alacritty-theme.git $HOME/.config/alacritty/theme_collection
echo
echo "alacritty is at your service."


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
sudo bash -c 'cat << EOF >> /etc/X11/xorg.conf.d/30-touchpad.conf
Section "InputClass"
    Identifier "touchpad catchall"
    Driver "libinput"
    Option "Tapping" "on"
EndSection
EOF'

echo
echo "Installing zorin os icon themes"

cd $HOME/ManBuild_Packs
git clone https://github.com/ZorinOS/zorin-icon-themes.git
cd $HOME/ManBuild_Packs/zorin-icon-themes
sudo cp -r * /usr/share/icons

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
