FROM openjdk:17-alpine
ARG ARTIFACT_NAME=github-redis-service-0.0.1-SNAPSHOT.jar
ENV ARTIFACT_NAME=${ARTIFACT_NAME}
RUN mkdir /app
COPY target/${ARTIFACT_NAME} /app/
EXPOSE 8080
# CMD java -jar /app/${ARTIFACT_NAME}
ENTRYPOINT [ "java", "-jar", "/app/${ARTIFACT_NAME}" ]