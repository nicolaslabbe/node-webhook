#!/bin/bash
# . ./.env

error_exit() {
  echo "$1" 1>&2
  exit 1
}
echo "\n\n\n\n\n" >> logs/deploy.txt
echo $USER >> logs/deploy.txt

# "####################"
# "git pull            "
# "####################"
echo "\n" >> logs/deploy.txt
git pull origin master >> logs/deploy.txt

echo "deploying on ${NODE_ENV} with user ${USER} using $(node --version)"

# "####################"
# " start server       "
# "####################"

# "pm2 stop webhook"
echo "\n" >> logs/deploy.txt
pm2 stop webhook >> logs/deploy.txt
# "pm2 start webhook.js"
echo "\n" >> logs/deploy.txt
pm2 start webhook.js >> logs/deploy.txt

# "pm2 list"
echo "\n" >> logs/deploy.txt
pm2 list >> logs/deploy.txt

exit