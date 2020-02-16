#!/bin/bash

# Misc
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

# Unsafe user install
source ~/.rcutils.sh
# End of unsafe user install

# Safe user install
load_file ~/.aliases.sh
load_file ~/.keys.sh
load_file ~/.bss.sh
