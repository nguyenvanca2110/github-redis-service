
FROM openjdk:17-alpine

# Refer to Maven build -> finalName
ARG JAR_FILE=target/github-redis-service-0.0.1-SNAPSHOT.jar

# cd /opt/app
WORKDIR /opt/app

# cp target/spring-boot-web.jar /opt/app/app.jar
COPY ${JAR_FILE} redis-web-app.jar

EXPOSE 8080
# java -jar /opt/app/app.jar
ENTRYPOINT ["java","-jar", "redis-web-app.jar"]