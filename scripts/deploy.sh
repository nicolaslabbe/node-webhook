#!/bin/bash
# . ./.env

error_exit() {
  echo "$1" 1>&2
  exit 1
}

echo "####################"
echo "git pull            "
echo "####################"
git pull origin master

echo "deploying on ${NODE_ENV} with user ${USER} using $(node --version)"

echo "####################"
echo " start server       "
echo "####################"

pm2 stop webhook
pm2 delete webhook
sleep 1
pm2 start webhook

sleep 2
pm2 list