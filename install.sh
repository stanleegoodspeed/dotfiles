#!/usr/bin/env bash
# ensure you set the executable bit on the file with `chmod u+x install.sh`

# If you remove the .example extension from the file, once your workspace is created and the contents of this
# repo are copied into it, this script will execute.  This will happen in place of the default behavior of the workspace system,
# which is to symlink the dotfiles copied from this repo to the home directory in the workspace.
#
# Why would one use this file in stead of relying upon the default behavior?
#
# Using this file gives you a bit more control over what happens.
# If you want to do something complex in your workspace setup, you can do that here.
# Also, you can use this file to automatically install a certain tool in your workspace, such as vim.
#
# Just in case you still want the default behavior of symlinking the dotfiles to the root,
# we've included a block of code below for your convenience that does just that.

set -euo pipefail

DOTFILES_PATH="$HOME/dotfiles"

# Symlink dotfiles to the root within your workspace
find $DOTFILES_PATH -type f -path "$DOTFILES_PATH/.*" |
while read df; do
  link=${df/$DOTFILES_PATH/$HOME}
  mkdir -p "$(dirname "$link")"
  ln -sf "$df" "$link"
done

# Download and install Yarn 3.2.1
YARN_VERSION="3.2.1"
YARN_URL="https://github.com/yarnpkg/yarn/releases/download/v$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz"
YARN_INSTALL_DIR="$HOME/.yarn"

# Create installation directory
mkdir -p $YARN_INSTALL_DIR

# Download and extract Yarn
curl -L $YARN_URL | tar -xz -C $YARN_INSTALL_DIR --strip-components=1

# Add Yarn to PATH
export PATH="$YARN_INSTALL_DIR/bin:$PATH"

# Verify installation
yarn --version

# Download and install Node.js 20.11.0
NODE_VERSION="20.11.0"
NODE_URL="https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-darwin-x64.tar.gz"
NODE_INSTALL_DIR="$HOME/.node"

# Create installation directory
mkdir -p $NODE_INSTALL_DIR

# Download and extract Node.js
curl -L $NODE_URL | tar -xz -C $NODE_INSTALL_DIR --strip-components=1

# Add Node.js to PATH
export PATH="$NODE_INSTALL_DIR/bin:$PATH"

# Verify installation
node --version
