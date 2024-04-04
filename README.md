# dotfiles

## Config files

The dotfiles are meant to work wit some config files that are not included in this repository. The idea is to have personal configs that are not shared with others (like the list of languages you would like to query cht.sh with).

The following files are expected to be in the $HOME directory:
#### $HOME/.folders
- List of the parent directories you work with
- Used by [zoxide](https://github.com/ajeetdsouza/zoxide)
- It is a simple text file with one directory per line (relative to $HOME)
e.g.
```
Projects/Personal
Projects/Work
freelance
```

Then if you have a directory `Projects/Personal/MyProject` you can jump to it by typing `cd MyProject` and it will appear also in the tmux `C-x p` menu.

#### $HOME/.languages
- List of programming languages you are familiar with
- Used by [cht.sh](https://cht.sh/)
- It is a simple text file with one language per line
e.g.
```
bash
python
javascript
```

#### $HOME/.commands
- List of commands you are familiar with
- Used by [cht.sh](https://cht.sh/)
- It is a simple text file with one command per line
e.g.
```
ln
grep
awk
```

## Manual Installation
- Clone this repository (in $HOME/.config directory)
- Install [zsh](https://www.zsh.org/)
  - Ubuntu: `sudo apt install zsh`
  - MacOS: `brew install zsh`
- Copy `.zshrc` to your $HOME directory
- Create .folders in $HOME directory
- Install [zoxide](https://github.com/ajeetdsouza/zoxide)
  - Recommend: `curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash`
- Install [NeoVim](https://neovim.io/)
  - Ubuntu: [instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md#appimage-universal-linux-package)
  - MacOS: `brew install neovim`
- Copy `nvim` directory to your `$HOME/.config` directory
- Install [NVM](https://github.com/nvm-sh/nvm)
  - `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash`
- Install [FZF](https://github.com/junegunn/fzf)
  - Ubuntu: `sudo apt install fzf`
  - MacOS: `brew install fzf`
- Install [ripgrep](https://github.com/BurntSushi/ripgrep)
  - Ubuntu: `sudo apt install ripgrep`
  - MacOS: `brew install ripgrep`
- Install [tmux](https://github.com/tmux/tmux)
  - Ubuntu: `sudo apt install tmux`
  - MacOS: `brew install tmux`
- Create .languages and .commands in $HOME directory
- Install [lazygit](https://github.com/jesseduffield/lazygit)
  - Ubuntu: [instructions](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#ubuntu)
  - MacOS: `brew install lazygit`

## Automatic Installation (Ubuntu)
- Clone this repository (in $HOME/.config directory)
- Install [neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md#appimage-universal-linux-package)
- Run `./install.sh`

## Automatic Installation (MacOS)
- Coming soon... :)

## Windows
- Coming (no that) soon... :)
