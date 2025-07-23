# # Gunakan base image dengan JDK 21
# FROM eclipse-temurin:21-jdk-alpine

# VOLUME /tmp
# WORKDIR /app

# # Copy file JAR hasil build Spring Boot
# COPY target/api-0.0.1-SNAPSHOT.jar app.jar

# EXPOSE 8080

# # Jalankan aplikasi
# ENTRYPOINT ["java", "-jar", "app.jar"]

# # # Gunakan JDK 21
# # FROM eclipse-temurin:21-jdk-alpine

# # # Tambahkan JAR file ke image
# # ARG JAR_FILE=target/*.jar
# # COPY target/api-0.0.1-SNAPSHOT.jar app.jar

# # # Jalankan aplikasi
# # ENTRYPOINT ["java", "-jar", "/app.jar"]

# Build Stage dari tito
FROM openjdk:21-jdk-slim AS build
WORKDIR /app
COPY pom.xml .
COPY mvnw .          
COPY .mvn ./.mvn      
COPY src ./src
RUN chmod +x ./mvnw 
RUN ./mvnw clean install -DskipTests

# Run Stage
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
