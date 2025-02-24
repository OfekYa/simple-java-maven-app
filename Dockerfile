# Stage 1: Build the JAR file
FROM maven:3.9.2-eclipse-temurin-17 AS build
ARG BUILD_VERSION
WORKDIR /app
COPY . .
RUN mvn versions:set -DnewVersion=${BUILD_VERSION} -DgenerateBackup=false
RUN mvn clean package -DskipTests
RUN ls -la target

# Stage 2: Run the JAR file
FROM eclipse-temurin:17-jre

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
