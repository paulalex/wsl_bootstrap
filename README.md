# wsl_bootstrap
Bootstrap ubuntu 18.04 under WSL for development, the scripts should be ran as your normal user and ***not as root!***

## Usage

### Initial installation
    
##### Clone Repository

  `git clone https://github.com/paulalex/wsl_bootstrap.git`

##### Bootstrap WSL

`bash setup.sh`

### Update and resync
To pull in new changes and 're-source' `.bashrc` you need only run the following command (do not run )

`bash sync.sh`

## Important Note
Currently the git config contains my name and email address so ensure that you change this:

> [user]
>  # Please adapt and uncomment the following lines:
>  name = Paul Ockleford
>
>  email = paul.ockleford@edfenergy.com
