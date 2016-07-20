FROM node:6

RUN apt-get update && apt-get install -y make g++ libssl-dev libicu-dev

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" && \
    curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" && \
    gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc && \
    grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - && \
    mkdir /tmp/node && \
    tar -xJf "node-v$NODE_VERSION.tar.xz" -C /tmp/node --strip-components=1 && \
    rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt

RUN cd /tmp/node && ./configure --with-intl=full-icu --download=all && make && make install
