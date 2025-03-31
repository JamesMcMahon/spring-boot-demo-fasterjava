#!/usr/bin/env bash
set -e

REPOSITORY_NAME="fasterjavademo"
TAG="0.0.1-SNAPSHOT"
IMAGE_NAME=$REPOSITORY_NAME:$TAG

docker build -t $IMAGE_NAME .