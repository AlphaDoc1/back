# Stage 1: Build the application using Maven
FROM maven:3.8.6-openjdk-17-slim AS build
WORKDIR /app
# Copy the Maven configuration and dependencies first to cache them
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application using a lightweight JDK image
FROM openjdk:17-jdk-alpine
WORKDIR /app
# Replace 'your-app-name.jar' with the actual JAR name from your target folder
COPY --from=build /app/target/your-app-name.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
