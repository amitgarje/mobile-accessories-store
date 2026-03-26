# Stage 1: Build WAR using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run on Tomcat
FROM tomcat:10.1-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/target/mobile-accessories-store.war /usr/local/tomcat/webapps/ROOT.war

# Handle Render dynamic port
CMD sed -i "s/port=\"8080\"/port=\"${PORT}\"/g" /usr/local/tomcat/conf/server.xml && catalina.sh run