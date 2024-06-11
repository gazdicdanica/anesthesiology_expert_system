# Dockerfile for kjar Project
FROM maven:3.8.4-openjdk-17-slim AS build

# Set the working directory
WORKDIR /kjar

# Copy only the pom.xml to the container
COPY pom.xml .

# Create directories for source code
RUN mkdir -p /model/src

# Note: We will mount the model project's src directory as a volume during the build process

# Build the kjar project
RUN mvn dependency:go-offline  # Download dependencies first
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /kjar/target/kjar-0.0.1-SNAPSHOT.jar ./kjar.jar
CMD ["java", "-jar", "kjar.jar"]
