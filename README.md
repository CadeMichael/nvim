# Server Side Neovim Config

something small and not bloated for editing code on a remote server

## Installing a working neovim on debian

- assuming you're on debian

```sh
# add the ppa repository
sudo add-apt-repository ppa:neovim-ppa/unstable
# install neovim
sudo apt install neovim
```

## Package choice

- I prioritize packages that are pure lua with minimal requirements.
- I don't know what can or can't be compiled on the server.
- main functionality relates to text editing less on language features.
    + surround
    + treesitter
    + tmux
    + oil
    + telescope

## getting up and running

- once installed python requires `pyright` and c / c++ requires `clang`
- must install tree-sitter grammers with `:TSInstall <langauge>`
