if [ -x "$(command -v zsh)" ]; then
    echo "zsh is already installed"
else
    echo "zsh is not installed"
    echo "installing zsh"
    sudo apt-get install zsh
fi

ZOXIDE_PATH=~/.local/bin

if [ -x "$(command -v $ZOXIDE_PATH/zoxide)" ]; then
    echo "zoxide is already installed"
else
    echo "zoxide is not installed"
    echo "installing zoxide"
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/master/install.sh | bash
fi

echo "Configuring zsh"
rm ~/.zshrc
cp ~/.config/dotfiles/zsh/.zshrc ~/.zshrc

touch ~/.folders

echo "Remember to restart your terminal to apply changes (source ~/.zshrc couldn't work, pls restart terminal)"

