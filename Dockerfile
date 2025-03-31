# Use AdoptOpenJDK JDK 24 as the base image
FROM openjdk:24-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven or Gradle wrapper files to the container
COPY mvnw* pom.xml ./
COPY .mvn .mvn/

COPY build-cds.sh .

# Copy the source code
COPY src src/

# Build the Spring Boot application (for Maven)
RUN ./build-cds.sh

# Use a minimal JRE runtime image for the final container
FROM openjdk:24-slim

# Set working directory inside the container
WORKDIR /app

# Copy the built JAR from the build container
COPY --from=build /app/docker-cds/fasterjavademo-0.0.1-SNAPSHOT.jar docker-cds/fasterjavademo-0.0.1-SNAPSHOT.jar
COPY --from=build /app/docker-cds/lib/ docker-cds/lib/.
COPY --from=build /app/*.jsa app.jsa

# Expose the application's port (adjust if needed)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-XX:SharedArchiveFile=app.jsa", "-jar", "docker-cds/fasterjavademo-0.0.1-SNAPSHOT.jar"]