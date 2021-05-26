# docker版本flexget

**集成了flexget_qbittorrent_mod，autoremove-torrents魔改版flexget插件以及flexget-nexusphp插件**

---

## 使用方法

```sh
docker run -d \
    --name=flexget \
    --network host\ [或者 -p 3539:3539 \]
    -v [config路径]:/config \
    -v [downloads路径]:/downloads \
    -e FG_WEBUI_PASSWD=Qwer@1357 \
    -e FG_LOG_LEVEL=info \
    -e FG_LOG_FILE=flexget.log \
    -e PUID=[puid] \
    -e PGID=[pgid] \
    barton0426/docker-flexget-autoremove-torrents-plugin
```
## Github链接

https://github.com/barton0426/flexget_qbittorrent_mod

## 特别感谢

https://github.com/lhllhx/flexget_qbittorrent_mod

https://github.com/meatballgithub/flexget-autoremove-torrents

https://github.com/Juszoe/flexget-nexusphp

