#!/bin/bash
# . ./.env

error_exit() {
  echo "$1" 1>&2
  exit 1
}

echo "deploying on ${NODE_ENV} with user ${USER} using $(node --version)"

echo "####################"
echo "install npm package"
echo "####################"

NODE_ENV=development npm prune || error_exit "error pruning"

# echo 'npm install:'
# NODE_ENV=development npm install || error_exit "error updating npm dependencies"

# echo 'local outdated:'
# NODE_ENV=development npm outdated --depth=0 || error_exit "error fetching npm outdated (local)"

# echo 'global outdated:'
# NODE_ENV=development npm outdated -g --depth=0 || error_exit "error fetching npm outdated (global)"

# echo "####################"
# echo " build tasks        "
# echo "####################"

# NODE_ENV=development npm run init || error_exit "init project"

echo "####################"
echo " start server       "
echo "####################"

pm2 stop all
pm2 delete all

# NODE_ENV=development npm run build || error_exit "start server"

sleep 2
pm2 list