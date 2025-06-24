# Stage 1: Build using Maven + JDK 13
FROM maven:3.6.3-jdk-13 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run using JDK 13 runtime
FROM openjdk:13-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

