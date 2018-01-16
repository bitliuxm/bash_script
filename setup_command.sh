#! /bin/bash

echo "$*"

# todo add args == 0 to print help

while getopts "adbvsthzm" optname
  do
    case "$optname" in
      "h")
		cat << EOF
+--------------------------------------------------------------
=====please modify /etc/apt/source.list manually first=====
options are:
a: not implmented  
d:default = basic + vim + zsh + tmux 
b basic
v vim support
s add ss and tsock support
h host support
z zsh and oh my zsh support
t tmux
p python and pip app(bypy markdown) support
m misc support // all others
+--------------------------------------------------------------+
EOF
		exit
        ;;
      "a")
		ALL=1
        ;;
      "d")
		DEFAULT=1
		BASIC=1
		VIM_SUPPORT=1
		ZSH_OH_SUPPORT=1
		TMUX_SUPPORT=1
        ;;
      "b")
		BASIC=1
        ;;
      "s")
		SS_SUPPORT=1
        ;;
      "v")
		VIM_SUPPORT=1
        ;;
      "h")
		HOST_SUPPORT=1
        ;;
      "z")
		ZSH_OH_SUPPORT=1
        ;;
      "t")
		TMUX_SUPPORT=1
        ;;
      "p")
		PYTHON_APP_SUPPORT=1
        ;;
      "m")
		MISC_SUPPORT=1
        ;;
      "?")
        echo "Unknown option $OPTARG"
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        ;;
    esac
  done


if [ -n "$BASIC$ALL" ]
then
# update sources.list
sudo mv /etc/apt/sources.list /etc/apt/sources.list.backup
sudo cp sources.list /etc/apt/sources.list

# need to use sudo 
sudo apt-get update
sudo apt-get install -y openssh-server
mkdir workspace
sudo apt-get install -y vim-nox
sudo apt-get install -y adb
sudo apt-get install -y curl
sudo apt-get install -y repo
sudo apt install -y git
fi

if [ -n "$SS_SUPPORT$ALL" ]
then
sudo apt install -y shadowsocks
sudo add-apt-repository -y ppa:hzwhuang/ss-qt5
sudo apt-get update
sudo apt-get install -y shadowsocks-qt5
sudo apt-get install -y tsocks

# move the sslocal@myserver.service to /lib/systemd/system and link to etc/systemd/system/multi-user.target.wants/
sudo ln -sf /lib/systemd/system/sslocal@myserver.service /etc/systemd/system/multi-user.target.wants/sslocal@myserver.service
#sudo rm /etc/tsocks.conf
#sudo ln -sf /home/bit/workspace1/github/config/tsocks.conf /etc/tsocks.conf
fi

if [ -n "$HOST_SUPPORT$ALL" ]
then
# try to fetch the github
mkdir -p ~/workspace/github/
git clone https://git.coding.net/scaffrey/hosts.git ~/workspace/github/hosts
sudo cp /etc/hosts  /etc/hosts.default
sudo cp ~/workspace/github/hosts/hosts-files/hosts /etc/hosts
#hosts can not use ln
#sudo rm /etc/hosts
#sudo ln -sf /home/bit/workspace1/github/hosts/hosts /etc/hosts
fi


if [ -n "$BASIC$ALL" ]
then
# git clone 
git clone https://github.com/bitliuxm/bash_script.git ~/workspace/github/bash_script
git clone https://github.com/bitliuxm/config.git ~/workspace/github/config
git clone https://github.com/powerline/fonts.git ~/workspace/github/fonts

# make ln for all script
mkdir -p ~/bin
cd ~/workspace/github/bash_script
~/workspace/github/bash_script/make_ln_all ~/bin

ln -sf ~/workspace/github/config/gitconfig ~/.gitconfig
ln -sf ~/workspace/github/config/bashrc ~/.bashrc
ln -sf ~/workspace/github/config/clang-format-config  ~/.clang-format

fi

if [ -n "$TMUX_SUPPORT$ALL" ]
then
sudo apt-get install -y tmux
git clone https://github.com/bitliuxm/tmux-config.git ~/workspace/github/tmux-config
ln -sf ~/workspace/github/tmux-config/.tmux.conf ~/.tmux.conf
fi

if [ -n "$SAMBA_SUPPORT$ALL" ]
then
sudo apt-get install -y samba --fix-missing
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.default
#sudo rm /etc/samba/smb.conf
#sudo ln -sf /home/bit/workspace1/github/config/smb.conf /etc/samba/smb.conf
fi

if [ -n "$ZSH_OH_SUPPORT" ]
then
sudo apt-get install -y zsh
ln -sf ~/workspace/github/config/zshrc ~/.zshrc
sudo chsh -s /bin/zsh

# oh my zsh
chmod +x ~/workspace/github/config/oh_my_zsh_install.sh
~/workspace/github/config/oh_my_zsh_install.sh
fi

if [ -n "$VIM_SPF13_SUPPORT" ]
then
# spf13
# vim spf13 install, should only be excute as user
sudo apt-get install -y ack-grep
sudo apt-get install -y exuberant-ctags
#vim spf13 install, should only be excute as user
chmod +x ~/workspace/github/config/install_spf13.sh
~/workspace/github/config/install_spf13.sh
ln -sf ~/workspace/github/config/.vimrc.bundles.local ~/.vimrc.bundles.local
ln -sf ~/workspace/github/config/vimrc.before.local ~/.vimrc.before.local
ln -sf ~/workspace/github/config/vimrc.local ~/.vimrc.local
fi

if [ -n "$MISC_SUPPORT" ]
then

# for bash check
sudo apt-get install shellcheck

# for android build server
sudo apt-get install -y bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libesd0-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev

# for audit2allow
sudo apt-get install -y policycoreutils

### cron
# cron can not use ln
#sudo ln -sf   /home/bit/workspace1/github/config/crontab_user  /var/spool/cron/crontabs/bit

fi


if [ -n "$PYTHON_APP_SUPPORT" ]
then

sudo apt-get install -y python2.7-dev

#setup python basic
wget http://peak.telecommunity.com/dist/ez_setup.py
sudo python ez_setup.py
sudo easy_install pip

# setup baidupan
sudo pip install requests
sudo pip install bypy

### python markdown setup
#wget http://peak.telecommunity.com/dist/ez_setup.py
#sudo python ez_setup.py
#sudo easy_install pip
#sudo easy_install markdown
#sudo pip install pymdown-extensions
#sudo pip install PyYAML 
#sudo pip install Pygments
fi

