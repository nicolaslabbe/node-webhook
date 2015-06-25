#!/bin/bash
# . ./.env

error_exit() {
  echo "$1" 1>&2 >> logs/deploy.txt
  exit 1
}

mkdir logs
rm logs/deploy.txt
pwd >> logs/deploy.txt

echo "\n" >> logs/deploy.txt
git pull origin master >> logs/deploy.txt || error_exit "error git pull"
sleep 2

echo "deploying on ${NODE_ENV} with user ${USER} using $(node --version)" >> logs/deploy.txt

pm2 startOrRestart process.json -x >> logs/deploy.txt || error_exit "error restart webhook"
sleep 2

pm2 list || error_exit "error pm2 list"

exit