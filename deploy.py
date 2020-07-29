#!/usr/bin/env python3
import os
import sys
import glob
import shutil
import argparse


repo_url = 'https://github.com/dmitri-mcguckin/dotfiles'


def banner(banner_text):
    return banner_text + '\n' + ('-' * len(banner_text.strip())) + '\n'


def ask_user(question: str, options: list = ['y', 'n']):
    user_input = None

    while user_input not in options:
        user_input = input('{} {}: '.format(question, options)).strip()
    return user_input


def link(files, args):
    for src in files:
        src = os.path.abspath(src)
        dest = os.path.expanduser('~' + os.sep + src.split('/')[-1])

        if(os.path.exists(dest)):
            if(args.force_remove):
                remove = True
            elif(args.no_remove):
                remove = False
            else:
                remove = (ask_user('{} exists! remove first?'.format(dest)) == 'y')

            if(not args.dry_run and remove):
                if(os.path.isdir(dest)):
                    if(os.path.islink(dest)):
                        os.remove(dest)
                    else:
                        shutil.rmtree(dest)
                else:
                    os.remove(dest)
            else:
                if(not args.quiet):
                    print('skipping linking: {} -> {}'.format(dest, src))
                continue

        if(not args.quiet):
            print('linking file: {} -> {}'.format(dest, src))

        if(not args.dry_run):
            os.symlink(src, dest, target_is_directory=os.path.isdir(src))


def main(args):
    parser = argparse.ArgumentParser(prog='Dotfiles Deployment',
                                     description='Custom dotfiles deployment for Dmitri M.: {}.'.format(repo_url))
    parser.add_argument('-d', '--dry-run',
                        dest='dry_run',
                        action='store_true',
                        default=False,
                        help='perform the logic of the program without making any changes to the file system')

    parser.add_argument('-f', '--force-remove',
                        dest='force_remove',
                        action='store_true',
                        default=False,
                        help='force the removal of any preexisting dotfiles before linking')

    parser.add_argument('-n', '--no-remove',
                        dest='no_remove',
                        action='store_true',
                        default=False,
                        help='skip any dotfile linking that would otherwise require removal first')

    parser.add_argument('-q', '--quiet',
                        dest='quiet',
                        action='store_true',
                        default=False,
                        help='enable quiet mode for deployment')

    parser.add_argument('-s', '--shell',
                        dest='shell_type',
                        default=os.getenv('SHELL'),
                        help='specify the shell dotfiles to deploy')

    args = parser.parse_args(args)
    name = args.shell_type.split('/')[-1]
    type = args.shell_type

    if(not args.quiet):
        if(args.dry_run):
            print(banner('Enabled Dry Run Mode! None of these changes will be made!'))
        print('deploying for shell:\n\tname: {}\n\tpath: {}'.format(name, type))

    common_files = list(map(lambda x: os.path.abspath(x), glob.glob('common' + os.sep + '.*')))
    link(common_files, args)

    if(os.path.exists(name)):
        shell_files = glob.glob(name + os.sep + '.*')
        link(shell_files, args)
    elif(not args.quiet):
        print('no dotfiles exist for {}!'.format(name))


if __name__ == '__main__':
    try:
        main(sys.argv[1:])
    except KeyboardInterrupt:
        print(banner('\n\nPrematurely received signal-interupt!'))
