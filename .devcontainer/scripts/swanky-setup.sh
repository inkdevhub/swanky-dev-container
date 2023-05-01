#!/bin/bash

git_user=$(grep -oP "(?<=user:).*" /host-home/git_creds) || git_user=""
git_email=$(grep -oP "(?<=email:).*" /host-home/git_creds) || git_email=""

git config --global "user.name" $git_user
git config --global "user.email" $git_email

# Fix memory leakage from aarm64 mac
echo "[net]" > $CARGO_HOME/config.toml
echo "git-fetch-with-cli = true" >> $CARGO_HOME/config.toml

rustup default stable
rustup update
rustup update nightly
rustup component add rust-src
rustup component add rust-src --toolchain nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
rustup default nightly

cargo install cargo-dylint dylint-link
cargo install cargo-contract --force --version 2.1.0

swanky_folder="/opt/swanky"

if [ ! -d "$swanky_folder" ]; then
  wget -O /tmp/swanky.tar.gz https://github.com/AstarNetwork/swanky-cli/releases/download/v2.1.1/swanky-v2.1.1-32e0874-linux-x64.tar.gz && sudo tar -xf /tmp/swanky.tar.gz -C /opt
fi

link_path="/usr/local/bin/swanky"
swanky_bin_path="/opt/swanky/bin/swanky"

if [ ! -L "$link_path" ]; then
  sudo ln -s "$swanky_bin_path" "$link_path"
fi

sudo chown vscode /workspace

if ! npm list -g | grep -q "serve"; then
  echo "serve is not installed globally, installing..."
  npm install -g serve
else
  echo "serve is already installed globally"
fi
