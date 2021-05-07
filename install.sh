#!/bin/bash

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git $HOME/depot_tools
export PATH=$HOME/depot_tools:$PATH
if [[ $APPVEYOR_BUILD_WORKER_IMAGE == 'macOS' ]]; then
    curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
    rustup target add aarch64-apple-darwin
    RINGRTC_PLATFORM=mac
else
    rustup target add aarch64-pc-windows-msvc
    rustup target add i686-pc-windows-msvc
    RINGRTC_PLATFORM=windows
fi
git clone --single-branch --branch add-windows-multi-arch-support dennisameling/ringrtc
