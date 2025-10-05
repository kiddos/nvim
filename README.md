Kiddos' Neovim Config
=====================

## build AppImage

```sh
git clone https://github.com/neovim/neovim -b master --depth=1
cd neovim
make CMAKE_BUILD_TYPE=Release  CMAKE_INSTALL_PREFIX=`pwd`/AppDir/usr
make install
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
wget https://raw.githubusercontent.com/neovim/neovim/master/runtime/nvim.png -O AppDir/usr/share/icons/hicolor/256x256/apps/nvim.png
chmod +x linuxdeploy-x86_64.AppImage appimagetool-x86_64.AppImage
./linuxdeploy-x86_64.AppImage --appdir AppDir -e AppDir/usr/bin/nvim -d AppDir/usr/share/applications/nvim.desktop -i AppDir/usr/share/icons/hicolor/256x256/apps/nvim.png
./appimagetool-x86_64.AppImage AppDir
```

## Install

```sh
cd ~/.config
git clone https://github.com/kiddos/nvim
```

### Language servers

- basecode-lsp

```sh
cargo install --git https://github.com/kiddos/basecode-lsp.git
```

- rust

```sh
rustup component add rust-analyzer
```

- clangd

```sh
sudo apt install clangd
```

- python

```sh
pip install -U 'python-language-server[all]'
```

- web

```sh
npm install -g typescript-language-server typescript vscode-langservers-extracted cssmodules-language-server
```

- shell

```sh
npm install -g bash-language-server 
```

- cmake

```sh
pip install cmake-language-server
```

### tools

- prettier

```sh
npm install -g prettier
```
