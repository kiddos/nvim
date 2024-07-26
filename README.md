Kiddos' Neovim Config
=====================

## Install

```shell
cd ~/.config
git clone https://github.com/kiddos/nvim
```

### APM Server

```shell
cd nvim
pip install -r requirements.txt
```

### Language servers

- basecode-lsp

```shell
cargo install --git https://github.com/kiddos/basecode-lsp.git
```

- rust

```shell
rustup component add rust-analyzer
```

- clangd

```shell
sudo apt install clangd
```

- python

```shell
pip install -U 'python-language-server[all]'
```

- web

```shell
npm install -g typescript-language-server typescript vscode-langservers-extracted cssmodules-language-server
```

- shell

```shell
npm install -g bash-language-server 
```

- cmake

```shell
pip install cmake-language-server
```

### tools

- prettier

```shell
npm install -g prettier
```
