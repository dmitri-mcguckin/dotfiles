#!/bin/bash

# Unsafe user install
source ~/.rcutils
# End of user install

# Safe user install
load_file ~/.aliases
load_file ~/.keys

# User-defined bash settings
set completion-ignore-case on

HISTFILE="$HOME/.history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

# Start the shell
load_file ~/.shell-start
