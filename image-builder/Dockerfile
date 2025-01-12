FROM python:3.12
ENV PYTHONUNBUFFERED 1

RUN \
    echo "**** install build packages ****" && \
    apt update && apt install -y gcc cargo

WORKDIR /wheels

RUN \
    pip install -U pip && \
    pip wheel flexget && \
    pip wheel python-telegram-bot==21.9 && \
    pip wheel baidu-aip && \
    pip wheel pillow && \
    pip wheel pandas && \
    pip wheel matplotlib && \
    pip wheel fuzzywuzzy && \
    pip wheel python-Levenshtein && \
    pip wheel ply && \
    pip wheel chardet && \
    pip wheel colorama

FROM python:3.12
LABEL maintainer="barton0426@msn.com" \
      org.label-schema.name="flexget"
ENV PYTHONUNBUFFERED 1

COPY --from=0 /wheels /wheels
COPY root/ /

RUN \
    echo "**** install runtime packages ****" && \
    apt update && apt install -y --no-install-recommends \
    	wget unzip ca-certificates && \
    pip install -U pip && \
    pip install --no-cache-dir \
                --no-index \
                -f /wheels \
                flexget \
                python-telegram-bot==12.8 \
                baidu-aip \
                pillow \
                pandas \
                matplotlib \
                fuzzywuzzy \
                python-Levenshtein \
                ply \
                chardet \
				colorama && \
    echo "**** create flexget user and make our folders ****" && \
    mkdir /home/flexget && \
    groupmod -g 1000 users && \
    useradd -u 911 -U -d /home/flexget -s /bin/sh flexget && \
    usermod -G users flexget && \
    chown -R flexget:flexget /home/flexget && \
    chmod +x /usr/bin/entrypoint.sh && \
    rm -rf /wheels && \

    cd / && \
    wget https://github.com/madwind/flexget_qbittorrent_mod/archive/refs/heads/master.zip && unzip master.zip && \
    mv flexget_qbittorrent_mod-master plugins && rm master.zip && \
    wget -O plugins/nexusphp.py https://raw.githubusercontent.com/Juszoe/flexget-nexusphp/master/nexusphp.py && \
    wget https://github.com/meatballgithub/flexget-autoremove-torrents/archive/refs/heads/master.zip && unzip master.zip && \
    cp -rf flexget-autoremove-torrents-master/* /plugins && rm master.zip && rm -rf flexget-autoremove-torrents-master && \
    rm -rf /plugins/image-builder && rm /plugins/*.md && rm /plugins/*.yml && rm /plugins/.gitignore && rm /plugins/LICENSE && \
    apt purge -y wget unzip && apt autoremove -y && rm -rf /var/lib/apt/lists/*

ENV FG_WEBUI_PASSWD Qwer@1357
ENV TZ Asia/Shanghai

# add default volumes
VOLUME /config /downloads
WORKDIR /config

# expose port for flexget webui
EXPOSE 3539 3539/tcp

ENTRYPOINT ["sh","-c","/usr/bin/entrypoint.sh"]
