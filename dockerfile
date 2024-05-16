FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package
RUN ls -l /app/target
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/achieve-0.0.1-SNAPSHOT.war /app/achieve.war
EXPOSE 8080
RUN ls -l /app
CMD ["java", "-jar", "achieve.war"]

