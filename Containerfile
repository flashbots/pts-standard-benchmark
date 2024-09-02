FROM docker.io/library/ubuntu:24.04

ARG PTS_VERSION=10.8.4
ENV NO_PHODEVI_CACHE=TRUE

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl \
    libelf-dev \
    php-cli \
    php-xml \
    php-zip

RUN set -eu && \
    curl -fsSL -o /tmp/phoronix-test-suite.tar.gz \
    https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v${PTS_VERSION}/phoronix-test-suite-${PTS_VERSION}.tar.gz && \
    tar -xzf /tmp/phoronix-test-suite.tar.gz -C /tmp && \
    cd /tmp/phoronix-test-suite/ && \
    ./install-sh && \
    rm -rf /tmp/phoronix-test-suite.tar.gz /tmp/phoronix-test-suite

RUN phoronix-test-suite install \
  pts/fio-2.1.0 pts/stream-1.3.4 pts/build-linux-kernel-1.16.0

COPY flashloads-suite-definition.xml /var/lib/phoronix-test-suite/test-suites/local/flashloads/suite-definition.xml
COPY user-config.xml /etc/phoronix-test-suite.xml
COPY entrypoint.sh /entrypoint.sh

ENV TEST_RESULTS_NAME=flashloads-results
ENV OUTPUT_DIR=/test-results
ENV FORCE_TIMES_TO_RUN=3

ENTRYPOINT ["/entrypoint.sh"]
