#!/bin/bash

dev="$HOME/Developer"
dotfiles="$dev/jakubmovic/dotfiles"

if [[ -d "$dotfiles" ]]; then
  echo "Symlinking dotfiles from $dotfiles"
else
  echo "$dotfiles does not exist"
  exit 1
fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

for location in $(find home -name '.*'); do
  file="${location##*/}"
  file="${file%.sh}"
  link "$dotfiles/$location" "$HOME/$file"
done

if [[ `uname` == 'Darwin' ]]; then
  link "$dotfiles/sublime/Packages/" "$HOME/Library/Application Support/Sublime Text 3/Packages/"
  link "$dotfiles/home/config" "$HOME/.ssh/config"
fi
