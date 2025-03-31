#!/usr/bin/env bash
set -e

./mvnw -Pnative spring-boot:build-image -DskipTests