FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /workspace/app
COPY target/*.jar /workspace/app/

FROM eclipse-temurin:21-jre-alpine AS release
WORKDIR /app

RUN addgroup -g 1000 appgroup && \
    adduser -D -u 1000 -G appgroup appuser && \
    chown appuser:appgroup /app

USER appuser

COPY --from=build /workspace/app/*.jar /app/app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]