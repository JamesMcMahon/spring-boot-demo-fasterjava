#!/usr/bin/env bash
set -e

# Define container and image name
CONTAINER_NAME="timing-test"
REPOSITORY_NAME="fasterjavademo"
TAG="0.0.1-SNAPSHOT"
IMAGE_NAME=$REPOSITORY_NAME:$TAG

# Check if the container is already running and stop it
if [ "$(docker ps -q -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Stopping already running container: $CONTAINER_NAME"
    docker stop "$CONTAINER_NAME"
fi

# Run the container in the background
docker run --rm -d --name "$CONTAINER_NAME" -p 8080:8080 -e JAVA_OPTS="-Xms512m -Xmx512m" "$IMAGE_NAME"

#docker run --rm -d \
#  --name "$CONTAINER_NAME" \
#  --health-cmd="curl --fail --silent localhost:8080/actuator/health | grep UP || exit 1" \
#  --health-interval=10s \
#  --health-timeout=5s \
#  --health-retries=3 \
#  -p 8080:8080 "$IMAGE_NAME"

# Wait for the app to be healthy
echo "Waiting for application to become healthy..."
until curl -fs http://localhost:8080/actuator/health | grep -q '"status":"UP"'; do
    sleep 1
done
echo "Application is healthy"

#echo "Waiting for container health..."
#until [ "$(docker inspect --format='{{.State.Health.Status}}' $CONTAINER_NAME)" == "healthy" ]; do
#    sleep 1
#done
#echo "Application is healthy!"

# Get the startup time
STARTUP_TIME=$(curl -s http://localhost:8080/actuator/metrics/application.ready.time | jq '.measurements[0].value')
echo "Application Startup Time: ${STARTUP_TIME} ms"

# Stop the container
docker stop "$CONTAINER_NAME"