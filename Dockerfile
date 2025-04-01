FROM bellsoft/liberica-native-image-kit-container:jdk-23-nik-24-musl AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven or Gradle wrapper files to the container
COPY mvnw* pom.xml ./
COPY .mvn .mvn/

# Copy the source code
COPY src src/

# Build the Spring Boot application (for Maven)
RUN ./mvnw clean -Pnative native:compile -DskipTests

# Use a minimal JRE runtime image for the final container
FROM alpine:3.21

# Set working directory inside the container
WORKDIR /app

# Copy the built JAR from the build container
COPY --from=build /app/target/fasterjavademo .

# Expose the application's port (adjust if needed)
EXPOSE 8080

# Run the application
ENTRYPOINT ["./fasterjavademo"]