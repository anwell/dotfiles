#!/usr/bin/env bash

echo "Updating submodules"
git submodule update --init --depth 1

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "cd $dir"
cd "$dir"

files="$(git ls-tree --name-only HEAD | grep -vxE "README.md|LICENSE-MIT.txt|bootstrap.sh|.gitmodules|.gitignore")"
for file in $files; do
  if [ -e ~/"$file" ]; then
    echo "Removing ~/$file"
    rm ~/"$file"
  fi
  ln -s "$dir/$file" ~/"$file"
  echo "Created symlink $dir/$file"
done
