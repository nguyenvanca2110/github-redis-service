FROM openjdk:17-alpine
ARG ARTIFACT_NAME=github-redis-service-0.0.1-SNAPSHOT.jar
ENV ARTIFACT_NAME=${ARTIFACT_NAME}
RUN mkdir /app
COPY target/${ARTIFACT_NAME} /app/
CMD java -jar /app/${ARTIFACT_NAME}