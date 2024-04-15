#!/bin/sh

# abort on nonzero exitstatus
set -o errexit 
# abort on unbound variable
set -o nounset 

THEMES_DIR="../dotfiles/alacritty/themes"

rm --recursive --force ${THEMES_DIR}

mkdir -p ${THEMES_DIR}
git clone --depth 1 git@github.com:alacritty/alacritty-theme.git ${THEMES_DIR}

rm --recursive --force ${THEMES_DIR}/.git ${THEMES_DIR}/images
rm --force ${THEMES_DIR}/README.md ${THEMES_DIR}/print_colors.sh

mv ${THEMES_DIR}/themes/* ${THEMES_DIR}
rm --recursive ${THEMES_DIR}/themes

git add ${THEMES_DIR}
git commit --message "chore: Run scripts/fetch-alacritty-themes.sh"

