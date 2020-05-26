#!/bin/bash

files = ".bashrc"

for file in ${files}; do
  ln -sf ~/dotfiles/${file} ~/${file}
done
