#Installation and configuration on Ubuntu 12.04 LTS Desktop

##Install Ubuntu from cd

Simply flollow the guide to install.


##Change the source of apt-get

Normally the address of apt-get source will be configured  automatically depending on the location you selected during install. If you would like to change the source manually, e.g., to source of sjtu, you can do it by:
```bash
cd /etc/apt/
sudo cp sources.list sources.list_bk
sudo sed -i 's/cn.archive.ubuntu.com/ftp.sjtu.edu.cn/g' sources.list
apt-get update
apt-get upgrade
```

##Install tweak-tools and faience icon themes
###Ubuntu tweak-tools
[Ubuntu tweak](http://ubuntu-tweak.com/) is used for easier configuration of ubuntu. Install it by:
```bash
sudo add-apt-repository ppa:tualatrix/ppa
sudo apt-get update
sudo apt-get install ubuntu-tweak
```
###Faience themes
After installing tweak-tools you can install some third-party themes and icons, for example, one of the most famous beatiful themes, faience:
```bash
sudo add-apt-repository ppa:tiheum/equinox
sudo apt-get update
sudo apt-get install faience-theme
sudo apt-get install faience-icon-theme faenza-icon-theme
```
Then you can change it in tweak-tools.

##Install ibus-rime
In Ubuntu 12.02, you can install the [Sogou Chinese input method](http://pinyin.sogou.com/linux/), which however need some extra efforts (but easier in Ubuntu 14.04). So ibus-rime is supposed to be a better alternative, by following commands:
```bash
sudo add-apt-repository ppa:fcitx-team/nightly
sudo add-apt-repository ppa:lotem/rime
sudo apt-get update
sudo apt-get install ibus-rime
```
After which:

1. Go to ibus preference to set up rime.
2. Go to language suppport and install Chinese related packages.
3. Go to inputmethod switcher and restart X.

##Enable mounting while booting
For me there's another NTFS partition in my system shared with my Windows 7, so I enable it by adding following lines to the end of */etc/fstab*:
```
\#data partion
/dev/sda7 /mnt/data ntfs defaults 0 2
```

##Install dropbox
Normaly you can download the *.deb* file from [Dropbox's website](https://www.dropbox.com/) and install it.

##set up goagent
Goagent is used especially in China to "climb" the GFW. Gudiance is in [goagent's homepage](https://code.google.com/p/goagent/)

##install git, vim, tmux and omyzsh
###Git
For git, simply using apt-get:
```bash
sudo apt-get install git
```
###vim
Vim is defaultly installed in ubuntu, so what should be done is the configuration.

- You can download my [*.vimrc*](files/conf/.vimrc) with the version of July, 2014.
- Basically I use [Vundle](https://github.com/gmarik/Vundle.vim) to manage my plugins. Install it by:
```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Then run *:PluginInstall* in vim.
- Install ctags for vim:
```bash
sudo apt-get install ctags
```
- To install [solarized color setting](https://github.com/altercation/vim-colors-solarized), download solarized:
```bash
cd ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git
```
and move the .vim to certain directory:
```bash
mv solarized.vim ~/.vim/colors/
```

###tmux
Install tmux by:
```bash
sudo apt-get install tmux
```
And you can download my [*.tmux.conf*](files/conf/.tmux.conf) file, putting it under you home directory.

##omyzsh
Ubuntu use bash defaultly, we can change it to [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) which is more powerful:

1. Install zsh by:
```bash
sudo apt-get install zsh
```
2. Run:
```bash
chsh
```
to change the default login shell. For loacting the zsh shell you can type:
```bash
which zsh
```
or
```bash
cat /etc/shells
```
3. Install oh-my-zsh:
```bash
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
```

And you can download my [*.zshrc*](files/conf/.zshrc) file, putting it under you home directory.

Attention: When using [agnoster](https://gist.github.com/agnoster/3712874) theme, you have to install [powerline-patched fonts](https://gist.github.com/1595572) to display symbols.


##Set up jdk and eclipse
###jdk
* For setting up jdk, you can download it from its [home page](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* For setting up the environment variable, you can add following lines to *.bashrc* or *.zshenv*
```
export JAVA_HOME=/PATH/TO/JDK
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=$JAVA_HOME/jre/lib/ext:$JAVA_HOME/lib/tools.jar
```

###Eclipse
For eclipse, it's easy to download it from its [home page](https://www.eclipse.org/). One trival thing to mention is to add a shortcut in unity applications. You can do it by:
```bash
vim /usr/share/applications/eclipse.desktop
```
then configure the path to the icon:
```
[Desktop Entry]
Name=Eclipse
Comment=Eclipse SDK
Encoding=UTF-8
Exec=/PATH/TO/ECLIPSE
Icon=/PATH/TO/ICON
Terminal=false
Type=Application
Categories=Application;Development;
```
