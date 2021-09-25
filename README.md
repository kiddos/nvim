Kiddos' Neovim Config
=====================

## Quick Install

```shell
cd ~/.config
git clone https://github.com/kiddos/nvim
```

### install [packer](https://github.com/wbthomason/packer.nvim)

```shell
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### install [vim-plug](https://github.com/junegunn/vim-plug)

I am unable to move all the plugins to packer for now

```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### install plugins

```vim
:PlugInstall
:PackerSync
```

### APM Server

```shell
cd nvim
pip install -r requirements.txt
```
