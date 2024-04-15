#!/bin/sh

# abort on nonzero exitstatus
set -o errexit 
# abort on unbound variable
set -o nounset 

rm --recursive --force ../dotfiles/alacritty/themes

mkdir -p ../dotfiles/alacritty/themes
git clone --depth 1 git@github.com:alacritty/alacritty-theme.git ../dotfiles/alacritty/themes
rm --recursive --force ../dotfiles/alacritty/themes/.git

git add ../dotfiles/alacritty/themes
git commit --message "chore: Run scripts/fetch-alacritty-themes.sh"
