# wsl_bootstrap
Bootstrap ubuntu 18.04 under WSL for development, the scripts should be ran as your normal user and ***not as root!***

## Initial installation
    
#### Clone Repository

  `git clone https://github.com/paulalex/wsl_bootstrap.git`

#### Bootstrap WSL

`source setup.sh`

## Update and resync
To pull in new changes and 're-source' `.bashrc` you need only run the following command (do not run `setup.sh` again):

`source sync.sh`

## Important Note
Currently the `.gitconfig` contains my name and email address so ensure that you change this:

> [user]
>  name = Paul Ockleford
>
>  email = paul.ockleford@edfenergy.com

# What is installed?
Below you will find a list of all the software, aliases and bash commandline tools that are installed when you run `setup.sh`, running `sync.sh` will only bring in new changes from git and then resource `.bashrc` so that your shell is updated with any new environment variables and aliases etc.

## Development software
* `python 3.8`
* `Node 12.x`
* `NPM 6`
* `Tfenv`
* `Serverless`
* `Docker 19.3`
* `Docker Compose 1.17`

## Bash Commandline Support
* `software-properties-common`
* `ca-certificates`
* `apt-transport-https`
* `jq`
* `tree`
* `rename`
* `git-extras`

## Shell Functions
* `mcd()` - Make directory and enter it
* `envup()` - Load a `.env` file into your shell session
* `extract()` - Handle most common compression file extractions

## Aliases
* `alias python="python3.8"`
* `alias ..="cd .."`
* `alias ...="cd ../.."`
* `alias ....="cd ../../.."`
* `alias ~="cd ~"`
* `alias bk="cd -"`
* `alias ll="ls -al"`
* `alias lll="ls -latrhF"`
* `alias ln="ln -v"`
* `alias reload="source ~/.bashrc"`
* `alias mkdir="mkdir -p"`
* `alias files="du -hs * | sort -rh"`
* `alias path='echo $PATH | tr -s ":" "\n"'`

## Git
Additional configuration is performed for git, `git-extras` is installed and git is aliased as `g` and when used alone runs `git status`, when used in conjunction with any other valid `git` command will execute the command.

Autocomplete is set up for `g` and your current checked out git branch is added to your terminal prompt, e.g:

`wsl_bootstrap (master) $`

The following aliases are installed for git:

* `hist = log --all --graph --decorate --oneline`
* `co = checkout`
* `no = show --name-only`
* `st = status`
* `gi = init`
* `ga = add -A`
* `c = commit`
* `p = push`