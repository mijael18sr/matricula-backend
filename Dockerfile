# Etapa 1: Build
FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /app

# Copiar solo pom.xml primero para aprovechar cache de Docker
COPY pom.xml .

# Descargar dependencias (se cachea si pom.xml no cambia)
RUN mvn dependency:go-offline -B

# Copiar código fuente
COPY src ./src

# Compilar la aplicación sin tests y optimizada
RUN mvn clean package -DskipTests -Dmaven.test.skip=true \
    -Dmaven.compiler.debug=false \
    -Dmaven.compiler.debuglevel=none

# Etapa 2: Crear JRE personalizado con jlink
FROM eclipse-temurin:21-jdk-alpine AS jre-build

# Crear JRE mínimo con solo los módulos necesarios
RUN jlink \
    --add-modules java.base,java.desktop,java.instrument,java.management,java.naming,java.net.http,java.prefs,java.scripting,java.security.jgss,java.sql,jdk.unsupported,jdk.crypto.ec \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=2 \
    --output /javaruntime

# Etapa 3: Runtime ultra-optimizado
FROM alpine:3.19
WORKDIR /app

# Instalar solo glibc para Java
RUN apk add --no-cache libstdc++ && \
    rm -rf /var/cache/apk/*

# Copiar JRE personalizado
COPY --from=jre-build /javaruntime /opt/java/openjdk

# Crear usuario no root para seguridad
RUN addgroup -S spring && adduser -S spring -G spring

# Copiar solo el JAR final
COPY --from=build --chown=spring:spring /app/target/*.jar app.jar

# Cambiar al usuario no root
USER spring:spring

# Exponer el puerto de la aplicación
EXPOSE 8080

# Variables de entorno
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV SPRING_PROFILES_ACTIVE=prod
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+UseSerialGC -XX:TieredStopAtLevel=1 -Xss256k -Djava.security.egd=file:/dev/./urandom"

# Ejecutar la aplicación directamente con el JAR
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
