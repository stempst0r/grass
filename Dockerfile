FROM jlesage/baseimage-gui:debian-10-v4

LABEL org.opencontainers.image.authors="217heidai@gmail.com"

RUN set-cont-env APP_NAME "Grass"
RUN set-cont-env APP_VERSION "4.27.3"

COPY startapp.sh /startapp.sh
COPY main-window-selection.jwmrc /etc/jwm/main-window-selection.jwmrc

RUN apt-get update && \ 
    apt-get install -y curl ca-certificates locales && \
    apt-get auto-remove -y && \
    rm -rf /var/lib/apt/lists/*
#gdebi

RUN sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8
    
ARG APP_URL=http://http.us.debian.org/debian/pool/main/liba/libayatana-appindicator/libayatana-appindicator3-1_0.5.3-4_amd64.deb
RUN \
    curl -sS -L ${APP_URL} -o /tmp/libayatana-appindicator3-1.deb && \
    dpkg -i /tmp/libayatana-appindicator3-1.deb && \
    rm -f /tmp/libayatana-appindicator3-1.deb

ARG APP_URL=https://files.getgrass.io/file/grass-extension-upgrades/ubuntu-22.04/grass_4.27.3_amd64.deb
RUN \
    curl -sS -L ${APP_URL} -o /tmp/grass.deb && \
    dpkg -i /tmp/grass.deb && \
    rm -f /tmp/grass.deb