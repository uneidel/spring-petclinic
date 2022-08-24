FROM arm64v8/maven as builder

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package

FROM arm64v8/openjdk

COPY --from=builder /usr/src/app/target/*.jar /usr/app/app.jar
expose 8080
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=default","/usr/app/app.jar"]