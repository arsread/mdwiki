#Set up and configuration on OS X

This page is about my own experience in setting up OS X(Version 10.9.4).

##Configure language settings, trackpad settings, iCloud
All above setting can be found using spotlight(Command+Space).

- Laguage settings: To add language needed.
- Trackpad settings: To select gestures useful and helpful.
- iCloud: To synchronize between devices.

##Install Sogou input method and Dropbox
[Sogou input method](http://pinyin.sogou.com/mac/), [Dropbox](https://www.dropbox.com/) and other needed softwares can be downloaded and installed directory in their homepage.

##Install Homebrew
[Homebrew](http://brew.sh/) is a package manager used in Mac OS, similarly to apt-get in Ubuntu and yum in Fedora but needs compilation.
Install it by:
```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

##Install vim, tmux and oh-my-zsh
Vim and zsh is defaultly installed in Mac OS, tmux needs installation using brew:
```bash
brew install tmux
```
Further configuartoin refers to the part in my wiki on [set up Ubuntu 12.04](ubuntu12.md#install_git,_vim,_tmux_and_omyzsh).

Attention:You may need to add active path to ctags after installing it using homebrew.

##Install iTerm, Alfred, Manico, Spectacle
This part is optional, for mentioned Apps are useful from my perspective.

- [iTerm 2](http://iterm2.com/): A termial better than default.
  - You can also install [Solarized](http://ethanschoonover.com/solarized) color settings in iTerm.
  - If you use agnost theme in zsh, don't foget to set related fonts to enable special characteristics.
- [Alfred](http://www.alfredapp.com/): A search tool that more powerful than deault soptlight. Powerpack version is not free but provides more features.
- [Manico](http://manico.im/): It provides similar Launcher and task switcher as Ubuntu Unity.
- [Spectacle](http://spectacleapp.com/): A free window manager.
