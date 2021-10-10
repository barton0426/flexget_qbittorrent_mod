FROM docker.io/python:3-alpine
LABEL maintainer="barton0426@msn.com" \
      org.label-schema.name="flexget"
ENV PYTHONUNBUFFERED 1

RUN \
    # sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    # pip config set global.index-url https://mirrors.aliyun.com/pypi/simple && \
    echo "**** install runtime packages ****" && \
    apk add --no-cache \
        shadow \
        chromium \
        ca-certificates \
        tzdata && \
    rm -rf /var/cache/apk/*

RUN \
    pip install -U pip && \
    pip install --no-cache-dir \
                --no-index \
                flexget \
                python-telegram-bot==12.8 \
                baidu-aip \
                pillow \
                pandas \
                matplotlib \
                fuzzywuzzy \
                python-Levenshtein \
                pyppeteer \
                pyppeteer_stealth \
                ply \
                chardet && \
    #rm -rf /wheels

ADD link_chromium .

# add local files
COPY ./root/ /

RUN \
 echo "**** create abc user and make our folders ****" && \
 python link_chromium && \
 rm link_chromium && \
 groupmod -g 1000 users && \
 useradd -u 911 -U -d /home/flexget -s /bin/sh flexget && \
 usermod -G users flexget && \
 chown -R flexget:flexget /home/flexget && \
 chmod +x /usr/bin/entrypoint.sh && \
 cd / && \
 wget https://github.com/barton0426/flexget_qbittorrent_mod/archive/refs/heads/master.zip && unzip master.zip && \
 mv flexget_qbittorrent_mod-master plugins && rm master.zip && \
 wget -O plugins/nexusphp.py https://raw.githubusercontent.com/Juszoe/flexget-nexusphp/master/nexusphp.py && \
 wget https://github.com/meatballgithub/flexget-autoremove-torrents/archive/refs/heads/master.zip && unzip master.zip && \
 cp -rf flexget-autoremove-torrents-master/* /plugins && rm master.zip && rm -rf flexget-autoremove-torrents-master && \
 rm -rf /plugins/image-builder && rm /plugins/*.md && rm /plugins/*.yml && rm /plugins/.gitignore && rm /plugins/LICENSE

ENV FG_WEBUI_PASSWD Qwer@1357
ENV TZ Asia/Shanghai

# add default volumes
VOLUME /config /downloads
WORKDIR /config

# expose port for flexget webui
EXPOSE 3539 3539/tcp

ENTRYPOINT ["sh","-c","/usr/bin/entrypoint.sh"]

