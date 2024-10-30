FROM jlesage/baseimage-gui:debian-12-v4 as builder

RUN apt-get update && \ 
    apt-get install -y ca-certificates curl

RUN mkdir -p /grass && \
    mkdir -p /grass/lib

ARG APP_URL=http://ftp.us.debian.org/debian/pool/main/liba/libayatana-indicator/libayatana-indicator3-7_0.9.3-1_amd64.deb
RUN curl -sS -L ${APP_URL} -o /grass/lib/libayatana-indicator3-7.deb

ARG APP_URL=http://ftp.us.debian.org/debian/pool/main/liba/libayatana-appindicator/libayatana-appindicator3-1_0.5.92-1_amd64.deb
RUN curl -sS -L ${APP_URL} -o /grass/lib/libayatana-appindicator3-1.deb

ARG APP_URL=https://files.getgrass.io/file/grass-extension-upgrades/ubuntu-22.04/grass_4.27.3_amd64.deb
RUN curl -sS -L ${APP_URL} -o /grass/grass.deb


FROM jlesage/baseimage-gui:debian-12-v4

LABEL org.opencontainers.image.authors="217heidai@gmail.com"

RUN set-cont-env APP_NAME "Grass"
RUN set-cont-env APP_VERSION "4.27.3"

COPY startapp.sh /startapp.sh
COPY main-window-selection.jwmrc /etc/jwm/main-window-selection.jwmrc
COPY --from=builder /grass /

RUN apt-get update && \ 
    apt-get install -y ca-certificates locales libpango-1.0 libpangocairo-1.0 libgtk-3-0 libdbusmenu-gtk3-4 libdbusmenu-glib4 libayatana-ido3-0.4-0 libwebkit2gtk-4.1-0 && \
    apt-get auto-remove -y && \
    rm -rf /var/lib/apt/lists/*

RUN sed-patch 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8

RUN dpkg -i /grass/lib/libayatana-indicator3-7.deb && \
    dpkg -i /grass/lib/libayatana-appindicator3-1.deb && \
    dpkg -i /grass/grass.deb && \
    rm -rf /grass