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

echo "Remember to restart your terminal to apply changes (source ~/.zshrc couldn't work, pls restart terminal)"

