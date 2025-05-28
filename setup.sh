#!/usr/bin/env zsh
dotfilesDir=$(pwd)

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h "${HOME}/${1}" ]; then
    # Existing symlink
    echo "Removing existing symlink: ${dest}"
    rm "${dest}"

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv "${dest}" "${dest}.${dateStr}"

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv "${dest}" "${dest}.${dateStr}"
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}

linkDotfile .vim
linkDotfile .vimrc
linkDotfile .zshrc
linkDotfile .gitconfig
linkDotfile .inputrc
linkDotfile .curlrc
linkDotfile .gf

mkdir -p $dotfilesDir/.vim/bundle
cd $dotfilesDir/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall
