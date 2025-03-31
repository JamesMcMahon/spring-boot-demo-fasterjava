#!/usr/bin/env bash
set -e

./mvnw clean package -DskipTests

if [[ -d docker-cds ]]; then
  rm -rf docker-cds
fi

java \
    -Djarmode=tools \
    -jar target/fasterjavademo-0.0.1-SNAPSHOT.jar \
    extract --destination docker-cds

if [[ -f application.jsa ]]; then
  rm -f application.jsa
fi

java \
    -Dspring.context.exit=onRefresh \
    -XX:ArchiveClassesAtExit=application.jsa \
    -jar docker-cds/fasterjavademo-0.0.1-SNAPSHOT.jar