FROM eclipse-temurin:25-jdk-noble

ARG JAVAFX_VERSION=25.0.1
ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        unzip \
        fontconfig \
        libasound2t64 \
        libgl1 \
        libgtk-3-0 \
        libglib2.0-0t64 \
        libxxf86vm1 \
        libxext6 \
        libxi6 \
        libxrender1 \
        libxtst6 \
    && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    case "${TARGETARCH:-amd64}" in \
        amd64) JAVAFX_ARCH="x64" ;; \
        arm64) JAVAFX_ARCH="aarch64" ;; \
        *) echo "Unsupported Docker architecture: ${TARGETARCH}" >&2; exit 1 ;; \
    esac; \
    curl -fsSL "https://download2.gluonhq.com/openjfx/${JAVAFX_VERSION}/openjfx-${JAVAFX_VERSION}_linux-${JAVAFX_ARCH}_bin-sdk.zip" -o /tmp/openjfx.zip; \
    unzip -q /tmp/openjfx.zip -d /opt; \
    ln -s "/opt/javafx-sdk-${JAVAFX_VERSION}" /opt/javafx-sdk; \
    rm /tmp/openjfx.zip

ENV JAVAFX_HOME=/opt/javafx-sdk
ENV PATH="${JAVAFX_HOME}/bin:${PATH}"

RUN mkdir -p /workspace /home/developer/.gradle \
    && chown -R 1000:1000 /workspace /home/developer

ENV HOME=/home/developer
USER 1000:1000
WORKDIR /workspace

CMD ["./gradlew", "clean", "build"]
