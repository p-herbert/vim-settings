#!/bin/bash

set -evx

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Create diretories
mkdir -p "$SCRIPT_DIR/autoload" "$SCRIPT_DIR/bundle"

# Install pathogen
curl -LSso "$SCRIPT_DIR/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

# Setup submodules
git submodule init

git submodule update

# Setup coc
npm ci --prefix "$SCRIPT_DIR/bundle/coc.nvim"
npm run build --prefix "$SCRIPT_DIR/bundle/coc.nvim"
