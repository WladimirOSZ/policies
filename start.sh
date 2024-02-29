#!/bin/bash

docker network create rabbitmq_network
# Start app1
echo "Starting app1..."
cd ./app1
docker compose up app1 -d

# Start app2
echo "Starting app2..."
cd ../app2
docker compose up app2 -d

echo 'Waiting for rabbitmq to start...'
# await for rabbitmq to start
sleep 10
docker exec -it app2 bash -c "ruby start-bunny.rb"

echo -e "\n\e[1;32mSuccess! Apps are up and running!\e[0m"
echo -e "You can access the playground at \e[1;34mhttp://localhost:3001/graphiql\e[0m"
echo -e "To stop the apps, run \e[1;33m./stop.sh\e[0m"