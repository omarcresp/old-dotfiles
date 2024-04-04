# Check if zsh is installed, if not, install it
if [ -x "$(command -v zsh)" ]; then
    echo "zsh is already installed"
else
    echo "zsh is not installed"
    echo "installing zsh"
    sudo apt-get install zsh
fi

LOCAL_PATH=~/.local/bin

# Check if zoxide is installed, if not, install it
if [ -x "$(command -v $LOCAL_PATH/zoxide)" ]; then
    echo "zoxide is already installed"
else
    echo "zoxide is not installed"
    echo "installing zoxide"
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | bash
fi

echo "Configuring zsh"
mv ~/.zshrc ~/.zshrc.old
cp ~/.config/dotfiles/zsh/.zshrc ~/.zshrc
touch ~/.folders

echo "Configuring NeoVim"

# Check if neovim is installed, if not, throw an error
if [ -x "$(command -v nvim)" ]; then
    echo "neovim is already installed"
else
    echo "neovim is not installed"
    echo "pls installing neovim"

    exit 1
fi

mv ~/.config/nvim ~/.config/nvim-old
cp -r ~/.config/dotfiles/nvim ~/.config/nvim

# Check if nvm is installed, if not, install it
NVM_DIR="$HOME/.nvm/nvm.sh"
if [ -f "$NVM_DIR" ]; then
    echo "nvm is already installed"
else
    echo "nvm is not installed"
    echo "installing nvm"

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    source $NVM_DIR

    nvm install --lts
fi

# Check if fzf is installed, if not, install it
if [ -x "$(command -v fzf)" ]; then
    echo "fzf is already installed"
else
    echo "fzf is not installed"
    echo "installing fzf"
    sudo apt-get install fzf
fi

# Check if ripgrep is installed, if not, install it
if [ -x "$(command -v rg)" ]; then
    echo "ripgrep is already installed"
else
    echo "ripgrep is not installed"
    echo "installing ripgrep"
    sudo apt-get install ripgrep
fi

# Check if tmux is installed, if not, install it
if [ -x "$(command -v tmux)" ]; then
    echo "tmux is already installed"
else
    echo "tmux is not installed"
    echo "installing tmux"
    sudo apt-get install tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    cp ~/.config/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    cp ~/.config/dotfiles/tmux/tmux.sh ~/.local/bin/tmux.sh
fi

# Check if lazygit is installed, if not, install it
if [ -x "$(command -v lazygit)" ]; then
    echo "lazygit is already installed"
else
    echo "lazygit is not installed"
    echo "installing lazygit"
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
fi

echo "Remember to restart your terminal to apply changes (source ~/.zshrc couldn't work, pls restart terminal)"

