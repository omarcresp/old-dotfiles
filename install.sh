# Ensure install dev tools
echo "=== JACKCRES dotfiles: apt-get update"
sleep 1
sudo apt-get update

echo "=== JACKCRES dotfiles: install dev tools"
sleep 1

sudo apt-get install cmake unzip curl build-essential ninja-build

echo "=== JACKCRES dotfiles: dev tools installed"
sleep 1

# Check if zsh is installed, if not, install it
if [ -x "$(command -v zsh)" ]; then
    echo "=== JACKCRES dotfiles: zsh is already installed"
else
    echo "=== JACKCRES dotfiles: zsh is not installed"
    echo "=== JACKCRES dotfiles: installing zsh"
    sleep 1

    sudo apt-get install zsh

    echo "=== JACKCRES dotfiles: zsh installed"
fi

sleep 1

LOCAL_PATH=~/.local/bin

# Check if zoxide is installed, if not, install it
if [ -x "$(command -v $LOCAL_PATH/zoxide)" ]; then
    echo "=== JACKCRES dotfiles: zoxide is already installed"
else
    # echo "zoxide is not installed"
    # echo "installing zoxide"
    echo "=== JACKCRES dotfiles: installing zoxide"
    echo "=== JACKCRES dotfiles: downloading zoxide"
    sleep 1

    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | bash

    echo "=== JACKCRES dotfiles: zoxide installed"
fi

sleep 1

# echo "Configuring zsh"
echo "=== JACKCRES dotfiles: configuring zsh"
mv ~/.zshrc ~/.zshrc.old
cp ~/.config/dotfiles/zsh/.zshrc ~/.zshrc
touch ~/.folders
sleep 1

echo "=== JACKCRES dotfiles: configuring neovim"

# Check if neovim is installed, if not, throw an error
if [ -x "$(command -v nvim)" ]; then
    echo "=== JACKCRES dotfiles: neovim is already installed"
else
    echo "=== JACKCRES dotfiles: neovim is not installed"
    echo "pls installing neovim"

    exit 1
fi

sleep 1

mv ~/.config/nvim ~/.config/nvim-old
cp -r ~/.config/dotfiles/nvim ~/.config/nvim

# Check if nvm is installed, if not, install it
NVM_DIR="$HOME/.nvm"
if [ -f "$NVM_DIR/nvm.sh" ]; then
    echo "=== JACKCRES dotfiles: nvm is already installed"
else
    echo "=== JACKCRES dotfiles: nvm is not installed"
    echo "=== JACKCRES dotfiles: installing nvm"
    sleep 1

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    echo "=== JACKCRES dotfiles: nvm installed"
    echo "=== JACKCRES dotfiles: installing node lts"
    sleep 1

    source $NVM_DIR/nvm.sh

    nvm install --lts

    echo "=== JACKCRES dotfiles: node lts installed"
fi

sleep 1

# Check if fzf is installed, if not, install it
if [ -x "$(command -v fzf)" ]; then
    echo "=== JACKCRES dotfiles: fzf is already installed"
else
    echo "=== JACKCRES dotfiles: fzf is not installed"
    echo "=== JACKCRES dotfiles: installing fzf"
    sleep 1

    sudo apt-get install fzf

    echo "=== JACKCRES dotfiles: fzf installed"
fi

sleep 1

# Check if ripgrep is installed, if not, install it
if [ -x "$(command -v rg)" ]; then
    echo "=== JACKCRES dotfiles: ripgrep is already installed"
else
    # echo "ripgrep is not installed"
    # echo "installing ripgrep"
    echo "=== JACKCRES dotfiles: ripgrep is not installed"
    echo "=== JACKCRES dotfiles: installing ripgrep"
    sleep 1

    sudo apt-get install ripgrep

    echo "=== JACKCRES dotfiles: ripgrep installed"
fi

sleep 1

touch ~/.languages
touch ~/.commands

# Check if tmux is installed, if not, install it
if [ -x "$(command -v tmux)" ]; then
    echo "=== JACKCRES dotfiles: tmux is already installed"
else
    # echo "tmux is not installed"
    # echo "installing tmux"
    echo "=== JACKCRES dotfiles: tmux is not installed"
    echo "=== JACKCRES dotfiles: installing tmux"
    sleep 1

    sudo apt-get install tmux

    echo "=== JACKCRES dotfiles: tmux installed"
    echo "=== JACKCRES dotfiles: installing tpm"
    sleep 1

    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    echo "=== JACKCRES dotfiles: tpm installed"
    echo "=== JACKCRES dotfiles: configuring tmux"
    sleep 1

    cp ~/.config/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    cp ~/.config/dotfiles/tmux/tmux.sh ~/.local/bin/tm

    echo """javasript
go
bash""" > ~/.languages
    echo """grep
tar
ln""" > ~/.commands

    echo "=== JACKCRES dotfiles: tmux configured"
fi

# Check if lazygit is installed, if not, install it
if [ -x "$(command -v lazygit)" ]; then
    echo "=== JACKCRES dotfiles: lazygit is already installed"
else
    echo "=== JACKCRES dotfiles: lazygit is not installed"
    echo "=== JACKCRES dotfiles: installing lazygit"
    sleep 1

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz lazygit
    mv lazygit /tmp/lazygit
    sudo install /tmp/lazygit /usr/local/bin

    echo "=== JACKCRES dotfiles: lazygit installed"
fi

sleep 1

echo "Remember to restart your terminal to apply changes (source ~/.zshrc couldn't work, pls restart terminal)"

sleep 10
