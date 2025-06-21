# 빌드 단계: JDK를 사용하여 애플리케이션을 빌드합니다.
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /workspace

# Gradle 래퍼와 빌드 스크립트 복사
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# 소스 코드 복사
COPY src src

# Gradle 래퍼 실행 권한 부여 및 테스트 제외하고 빌드 실행
RUN chmod +x ./gradlew && ./gradlew build -x test --no-daemon

# 패키지 단계: JRE만 포함된 작은 이미지에 빌드된 JAR 파일을 복사합니다.
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# 빌드 단계에서 생성된 JAR 파일 복사
COPY --from=builder /workspace/build/libs/*.jar app.jar

# 애플리케이션 포트 노출 (기본값 8888)
EXPOSE 8888

# 컨테이너 시작 시 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
