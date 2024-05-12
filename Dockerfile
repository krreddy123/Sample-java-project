FROM maven:3.8.6-openjdk-11 AS builder
ARG RUN_NUMBER
ENV RUN_NUMBER=${RUN_NUMBER}
COPY pom.xml .
COPY src ./src
RUN mvn clean package -Dmaven.test.skip=true

FROM openjdk:11-jre-slim
ARG RUN_NUMBER
ENV RUN_NUMBER=${RUN_NUMBER}
COPY --from=builder /target/my-app-${RUN_NUMBER}.jar /app.jar
CMD ["java", "-jar", "app.jar"]
