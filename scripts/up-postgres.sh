#!/bin/bash
COLOR_YELLOW='\033[1;49;33m';
COLOR_CLEAN='\033[0m';
COLOR_GREEN='\033[0;32m';

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
cd $(dirname $SCRIPT_PATH)

echo " "
echo -e "${COLOR_YELLOW}========> Starting container db...${COLOR_CLEAN}"
docker compose up -d db
echo -e "${COLOR_GREEN}done${COLOR_CLEAN}"
