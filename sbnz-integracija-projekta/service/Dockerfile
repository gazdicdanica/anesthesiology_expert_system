# Dockerfile for Service Project
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory
WORKDIR /service

# Copy only the pom.xml to the container
COPY pom.xml .

# Create directories for source code
RUN mkdir -p /model/src
RUN mkdir -p /kjar/src

# Note: We will mount the model and kjar project's src directories as volumes during the build process

# Build the service project
RUN mvn dependency:go-offline  # Download dependencies first
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /service/target/service-0.0.1-SNAPSHOT.jar ./service.jar
EXPOSE 8080
CMD ["java", "-jar", "service.jar"]
