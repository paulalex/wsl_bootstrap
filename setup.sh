#!/usr/bin/env bash

# Update repos and upgrade ubuntu
echo "[INFO] Upgrading and updating apt"
sudo apt update
sudo apt upgrade -y
ulimit -n 50000

# Install useful and necessary commandline tools
echo "[INFO] Installing commandline tools [software-properties-common, ca-certificates, apt-transport-https, jq, tree, rename, git-extras, python3.8-dev, unzip]"
sudo apt install -y software-properties-common ca-certificates apt-transport-https jq tree rename git-extras python3.8-dev unzip

# Install python 3.8 from deadsnakes repo
echo "[INFO] Installing python 3.8"
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt install -y python3.8 python3-pip

# Install virtualenv wrapper
echo "[INFO] Installing virtual env wrapper"
python3.8 -m pip install virtualenvwrapper

# Install virtualenv wrapper
echo "[INFO] Installing virtual env wrapper"
python3.8 -m pip install virtualenvwrapper

echo "[INFO] Installing awsume"
python3.8 -m pip install awsume

echo "[INFO] Installing pre-commit"
python3.8 -m pip install pre-commit

# Stop git asking for password every time you interact with remote
echo "[INFO] Amending git config credential helper"
git config --global credential.helper store

# Install awscli and boto3
echo "[INFO] Installing awscli and boto3"
python3.8 -m pip install awscli boto3

# Install Node and NPM
echo "[INFO] Installing node v12 and npm"
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

# Install tfenv
echo "[INFO] Installing tfenv"
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* ~/.local/bin

# Install docker and docker-compose
echo "[INFO] Installing docker and docker compose"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
sudo apt-get -y install docker-ce
sudo usermod -aG docker ${USER}
sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "[INFO] Installing serverless framework"
sudo npm install -g serverless

echo "[INFO] Syncing dotfiles to ${HOME}"
  rsync --exclude ".git/" \
    --exclude ".gitignore" \
    --exclude "setup.sh" \
     --exclude "sync.sh" \
    --exclude "README.md" \
    -avh --no-perms . ~

# output to .bashrc
echo "[INFO] Sending Snippet to .bashrc"
cat <<'EOF' >> ~/.bashrc
alias python="python3.8"
alias editbash="vi ~/.bashrc"

# Execute source on all of the dotfiles
for file in ~/.{aliases,git_functions,shell_functions,environment}; do
  [ -r "${file}" ] && [ -f "${file}" ] && source "${file}"
done

unset file

# Sourcing virtual env wrapper
source ~/.local/bin/virtualenvwrapper.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Enable tab completion for 'g' by marking it as an alias for 'git'
if type _git &> /dev/null; then
  complete -o default -o nospace -F _git g
fi

# Install serverless framework using NPM, I have added a temporary
# workaround (aka a hack) because it seems we cannot install without
# using sudo but in doing so the ~/.config directory is then owned by root
# and so things like serverless will not run
sudo chown -R $USER:$(id -gn $USER) ~/.config
EOF


echo "[INFO] Sourcing ${HOME}/.bashrc"
source ~/.bashrc

# Confirmation of installations
echo "[INFO] Installation Complete, Confirm Installed Versions"

echo "[INFO] Installed Python Version $(python3.8 --version)"

echo "[INFO] Installed AWS CLI Version $(aws --version)"

echo "[INFO] Installed Tfenv Version $(tfenv --version)"

echo -e "[INFO] Installed Serverless Version \n$(serverless --version)"

echo "[INFO] Installed Docker Version $(docker --version)"

echo "[INFO] Installed Docker Compose Version $(docker-compose --version)"


