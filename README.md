# Dotfiles Deployment

My personal dot files

## Usage

`$` `./deploy`

```
usage: Dotfiles Deployment [-h] [-d] [-f] [-n] [-q] [-s SHELL_TYPE]

Custom dotfiles deployment for Dmitri M.: https://github.com/dmitri-mcguckin/dotfiles.

optional arguments:
-h, --help            show this help message and exit
-d, --dry-run         perform the logic of the program without making any changes to the file system
-f, --force-remove    force the removal of any preexisting dotfiles before linking
-n, --no-remove       skip any dotfile linking that would otherwise require removal first
-q, --quiet           enable quiet mode for deployment
-s SHELL_TYPE, --shell SHELL_TYPE
specify the shell dotfiles to deploy
```

## Available Shells for Deployment

* `/bash`: Born Again Shell
* `/common`: Shell-agnostic dotfiles
* `/zsh`: Z-Shell
