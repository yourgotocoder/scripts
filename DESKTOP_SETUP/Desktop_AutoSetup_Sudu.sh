sudo apt-get update -y
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget https://downloads.mongodb.com/compass/mongodb-compass_1.30.1_amd64.deb
sudo apt-get install -y curl openjdk-8-jdk-headless openjdk-8-jre-headless build-essential gtk2-engines-murrine gtk2-engines-pixbuf plank
sudo dpkg -i google-chrome-stable_current_amd64.deb
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install v16.17.0
sudo snap install --classic code
sudo snap install spotify

sudo dpkg -i mongodb-compass_1.30.1_amd64.deb
sudo snap install mysql-workbench-community

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo add-apt-repository universe
sudo apt install gnome-tweaks
tar xf Mojave-Dark.tar.xz
mkdir ~/.themes
mv Mojave-Dark ~/.themes
tar xf Mojave-CT-Classic.tar.xz
mkdir ~/.icons
mv Mojave-CT-Classic ~/.icons
unzip -qq macOS\ Cursor\ Set.zip
mv macOS\ Cursor\ Set ~/.icons
sudo apt-get remove gnome-shell-extension-ubuntu-dock aisleriot gnome-sudoku gnome-mines gnome-mahjongg