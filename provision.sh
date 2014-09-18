#!/bin/bash

for container_id in `docker ps -q`; do
  container_name=$(docker inspect --format='{{.Name}}' $container_id)

  if [[ $container_name =~ "mongodb" ]]; then
    mongo_is_running=1
  fi
done

if [[ ! $mongo_is_running ]]; then
  DATA_DIR=/opt/mongo/data
  mkdir -p $DATA_DIR

  docker rm mongodb || :
  docker run -d -p 27017:27017 -v $DATA_DIR:/data/db --name mongodb dockerfile/mongodb
fi

docker build -t lj-friend-feed-image .

docker stop lj-friend-feed || :
docker rm lj-friend-feed || :
docker run -d --link mongodb:mongodb --name lj-friend-feed lj-friend-feed-image
