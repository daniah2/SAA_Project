#! /usr/bin/bash

set -e

apt update -y
apt install unzip curl git jq -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

su - ubuntu << 'UBUNTU_EOF'

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
source ~/.nvm/nvm.sh

nvm install 22
nvm use 22
nvm alias default 22

git clone https://github.com/daniah2/simple-3-tiers-app.git

cd simple-3-tiers-app/backend/

npm install

export PORT=$(aws ssm get-parameter --name backend-port | jq -r '.Parameter.Value')
export DB_HOST=${DATABASE_HOSTNAME}
export DB_USER=$(aws secretsmanager get-secret-value --secret-id database-username-secret | jq -r ".SecretString")
export DB_PASS=$(aws secretsmanager get-secret-value --secret-id database-password-secret | jq -r ".SecretString")
export DB_NAME=$(aws ssm get-parameter --name database-name | jq -r '.Parameter.Value')
export DB_PORT=$(aws ssm get-parameter --name database-port | jq -r '.Parameter.Value')

node server.js

UBUNTU_EOF