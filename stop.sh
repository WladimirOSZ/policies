#!/bin/bash

# Stop app1
echo "Stopping app1..."
cd ./app1
docker compose down

# Stop app2
echo "Stopping app2..."
cd ../app2
docker compose down

# Remove network
echo "Removing network..."
docker network rm rabbitmq_network
echo "Apps are stopped!"

echo -e "You can start the apps by running \e[1;33m./start.sh\e[0m"
