# =========================
# Stage 1: Build WAR
# =========================
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app
RUN getent hosts mysql-183e7873-safiyahhshaikhhhh-c8f0.a.aivencloud.com && curl -v --connect-timeout 10 telnet://mysql-183e7873-safiyahhshaikhhhh-c8f0.a.aivencloud.com:12048

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

# Render's port
EXPOSE 10000

# Configure Tomcat for Render
CMD ["sh", "-c", "sed -i 's/port=\"8005\"/port=\"-1\"/' /usr/local/tomcat/conf/server.xml && sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-10000}\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
