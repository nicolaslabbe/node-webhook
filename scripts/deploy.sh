#!/bin/bash
# . ./.env

error_exit() {
  "$1" 1>&2 >> logs/deploy.txt
  exit 1
}

rm logs/deploy.txt
pwd >> logs/deploy.txt

pm2 restart webhook.js || error_exit "error restart webhook"
sleep 2
echo "\n pm2 restart webhook.js" >> logs/deploy.txt

echo "\n" >> logs/deploy.txt
git pull origin master >> logs/deploy.txt || error_exit "error git pull"
sleep 2

echo "deploying on ${NODE_ENV} with user ${USER} using $(node --version)" >> logs/deploy.txt

pm2 list || error_exit "error pm2 list"
sleep 2
echo "\n pm2 list" >> logs/deploy.txt

exit