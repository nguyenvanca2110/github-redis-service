FROM openjdk:17-alpine

MAINTAINER CaNV

COPY target/github-redis-service-0.0.1-SNAPSHOT.jar redis-web-app.jar

EXPOSE 8080
# With profile configuration
ENTRYPOINT [ "java", "-jar", "/redis-web-app.jar" ]
# Without profile configuration
#ENTRYPOINT [ "java", "-jar", "/grade-demo.jar" ]