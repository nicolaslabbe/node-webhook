#!/bin/bash
# . ./.env

error_exit() {
  echo "$1" 1>&2
  exit 1
}

rm logs/deploy.txt
echo pwd >> logs/deploy.txt

# "####################"
# "git pull            "
# "####################"
echo "\n" >> logs/deploy.txt
git pull origin master >> logs/deploy.txt

echo "deploying on ${NODE_ENV} with user ${USER} using $(node --version)" >> logs/deploy.txt

# "####################"
# " start server       "
# "####################"

echo "\n" >> logs/deploy.txt
pm2 restart webhook.js >> logs/deploy.txt

# "pm2 list"
echo "\n" >> logs/deploy.txt
pm2 list >> logs/deploy.txt

exit