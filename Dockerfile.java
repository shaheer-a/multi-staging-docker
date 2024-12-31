# Stage 1: Build Java Application
FROM maven:3.8.5-openjdk-11 AS builder

# Set the working directory for Maven
WORKDIR /app/java

# Copy the project files
COPY . .

# Build the Java application using Maven
RUN mvn clean package

# Stage 2: Final Image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/java/target/my-java-app.jar ./my-java-app.jar

# Command to run the Java application
CMD ["java", "-jar", "my-java-app.jar"]
