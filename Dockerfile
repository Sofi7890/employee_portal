# =========================
# Stage 1: Build WAR
# =========================
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests


# =========================
# Stage 2: Run on Tomcat 9
# =========================
FROM tomcat:9.0-jdk17-temurin

# Remove Tomcat's default applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy our WAR as ROOT application
COPY --from=build /app/target/ems-system.war /usr/local/tomcat/webapps/ROOT.war

# Render uses PORT environment variable
EXPOSE 10000

# Change Tomcat port from 8080 to Render's PORT
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-10000}\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]