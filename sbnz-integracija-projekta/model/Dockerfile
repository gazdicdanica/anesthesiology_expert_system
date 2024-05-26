# Dockerfile for Model Project
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /model
COPY pom.xml .
COPY src ./src
RUN mvn clean install -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /model
COPY --from=build /model/target/model-0.0.1-SNAPSHOT.jar ./model.jar
CMD ["java", "-jar", "model.jar"]
