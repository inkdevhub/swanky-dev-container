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
cargo install cargo-contract --force --version 1.5.1

swanky_folder="/opt/swanky"

if [ ! -d "$swanky_folder" ]; then
  wget -O /tmp/swanky.tar.gz https://github.com/AstarNetwork/swanky-cli/releases/download/v1.0.11/swanky-v1.0.11-103b620-linux-x64.tar.gz && sudo tar -xf /tmp/swanky.tar.gz -C /opt
fi

link_path="/usr/local/bin/swanky"
swanky_bin_path="/opt/swanky/bin/swanky"

if [ ! -L "$link_path" ]; then
  sudo ln -s "$swanky_bin_path" "$link_path"
fi

sudo chown vscode /workspace

npm i -g serve
