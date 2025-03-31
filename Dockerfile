# Use AdoptOpenJDK JDK 24 as the base image
FROM openjdk:24-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven or Gradle wrapper files to the container
COPY mvnw* pom.xml ./
COPY .mvn .mvn/

# Copy the source code
COPY src src/

# Build the Spring Boot application (for Maven)
RUN ./mvnw clean package -DskipTests

# Use a minimal JRE runtime image for the final container
FROM openjdk:24-slim

# Set working directory inside the container
WORKDIR /app

# Copy the built JAR from the build container
COPY --from=build /app/target/*.jar app.jar

# Expose the application's port (adjust if needed)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]