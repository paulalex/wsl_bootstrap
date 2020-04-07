#!/usr/bin/env bash

# Update repos and upgrade ubuntu
echo "[INFO] Upgrading and updating apt"
sudo apt update
sudo apt upgrade -y

# Install useful and necessary commandline tools
echo "[INFO] Installing commandline tools [software-properties-common, ca-certificates, apt-transport-https, jq, tree, rename, git-extras]"
sudo apt install -y software-properties-common ca-certificates apt-transport-https jq tree rename git-extras

# Install python 3.8 from deadsnakes repo
echo "[INFO] Installing python 3.8"
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt install -y python3.8 python3-pip

# output to .bashrc
echo "[INFO] Updating .bashrc"

cat <<'EOF' >> ~/.bashrc
alias python="python3.8"

# Execute source on all of the dotfiles
for file in ~/.{aliases,git_functions,shell_functions,environment}; do
  [ -r "${file}" ] && [ -f "${file}" ] && source "${file}"
done

unset file

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
EOF

echo "[INFO] Syncing dotfiles"
 # Sync files to home directory
  rsync --exclude ".git/" \
    --exclude ".gitignore" \
    --exclude ".DS_Store" \
    --exclude ".osx" \
    --exclude "dotfiles.sh" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms . ~

# echo "[INFO] Sourcing .bashrc"
source ~/.bashrc

# Install virtualenv wrapper
echo "[INFO] Installing virtual env wrapper"
python3.8 -m pip install virtualenvwrapper
source ~/.local/bin/virtualenvwrapper.sh

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

# Install serverless framework using NPM
echo "[INFO] Installing serverless framework"
sudo npm install -g serverless

# Install docker and docker-compose
echo "[INFO] Installing docker and docker compose"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
sudo apt-get -y install docker-ce
sudo usermod -aG docker ${USER}
sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
 
# Confirmation of installations
echo "[INFO] Installation Complete, Confirm Installed Versions"

echo "[INFO] Installed Python Version $(python3.8 --version)"

echo "[INFO] Installed AWS CLI Version $(aws --version)"

echo "[INFO] Installed Tfenv Version $(tfenv --version)"

echo -e "[INFO] Installed Serverless Version \n$(serverless --version)"

echo "[INFO] Installed Docker Version $(docker --version)"

echo "[INFO] Installed Docker Compose Version $(docker-compose --version)"


