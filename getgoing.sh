# exit on error
set -e
# defaults
DIR_DEF=$HOME; USER_DEF=$SUDO_USER; WS_DEF="go"
# cosmetic
LIGHT_GRAY="\033[0;90m"; RESET_COLOR="\033[0m"

printf "Press RETURN↵ to accept ${LIGHT_GRAY}(default)${RESET_COLOR}\n"

# workspace
printf "    Workspace name: ${LIGHT_GRAY}(${WS_DEF})${RESET_COLOR} "
read WS
if [[ -z $WS ]]; then
    WS=$WS_DEF
fi

# directory
DIR="${DIR_DEF}/${WS}"

# github
printf "    GitHub user: ${LIGHT_GRAY}(${USER_DEF})${RESET_COLOR} "
read USER
if [[ -z $USER ]]; then
    USER=$USER_DEF
fi

# create directories and set permissions
mkdir -p $DIR/src/github.com/$USER $DIR/bin $DIR/pkg
chown -R $SUDO_USER $DIR; chmod -R 755 $DIR
printf "✓ Created workspace: ${DIR}\n"

# append environment variables and update
printf "export GOROOT=\"/usr/local/go\"\nexport GOPATH=\"${DIR}\"\nexport PATH=\"${DIR}/bin:\$PATH\"\n" >> ~/.bash_profile
$(source ~/.bash_profile)
printf "✓ Environment variables updated\n"