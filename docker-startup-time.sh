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

# Ensure the Docker image exists
if ! docker images "$REPOSITORY_NAME" | grep -q "$TAG"; then
    echo "Docker image $IMAGE_NAME not found. Building it..."
    ./mvnw spring-boot:build-image -DskipTests
fi

# Run the container in the background
docker run --rm -d --name "$CONTAINER_NAME" -p 8080:8080 "$IMAGE_NAME"

# Wait for the app to be healthy
echo "Waiting for application to become healthy..."
until curl -fs http://localhost:8080/actuator/health | grep -q '"status":"UP"'; do
    sleep 1
done
echo "Application is healthy"

# Get the startup time
STARTUP_TIME=$(curl -s http://localhost:8080/actuator/metrics/application.ready.time | jq '.measurements[0].value')
echo "Application Startup Time: ${STARTUP_TIME} ms"

# Stop the container
docker stop "$CONTAINER_NAME"