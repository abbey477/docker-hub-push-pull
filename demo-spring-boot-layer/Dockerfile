FROM openjdk:18-jdk-alpine3.15 as builder
WORKDIR application
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:18-jdk-alpine3.15
WORKDIR application
COPY --from=builder application/dependencies/ ./
COPY --from=builder application/spring-boot-loader/ ./
COPY --from=builder application/snapshot-dependencies/ ./
COPY --from=builder application/application/ ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]

# docker build -f Dockerfile -t demo/springbootlayer:0.0.1 .
# https://springframework.guru/why-you-should-be-using-spring-boot-docker-layers/

