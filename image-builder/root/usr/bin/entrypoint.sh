#! /bin/sh
#
# entrypoint.sh

PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod -o -g "$PGID" flexget
usermod -o -u "$PUID" flexget

# remove config-lock
if [ -f "/config/.config-lock" ]; then
  echo "Removing lockfile"
  rm -f /config/.config-lock
fi

# copy config.yml
if [ -f "/config/config.yml" ]; then
  echo "Using existing config.yml"
else
  echo "New config.yml from template"
  cp /defaults/config.example.yml /config/config.yml
fi

# copy plugins
mkdir -p /config/plugins
cp -r -u /plugins/* /config/plugins

# set FG_WEBUI_PASSWD
if [ ! -z "${FG_WEBUI_PASSWD}" ]; then
  echo "Setting flexget web password to '${FG_WEBUI_PASSWD}'"
  flexget -c /config/config.yml web passwd "${FG_WEBUI_PASSWD}" | grep 'Updated password' >/dev/null 2>&1 &&
    echo "Updated password" ||
    echo "Oops, something went wrong"
fi

# permissions
chown -R flexget:flexget /config
chown -R flexget:flexget /downloads

su flexget -c "/usr/local/bin/flexget -c /config/config.yml -L ${FG_LOG_LEVEL:-info} daemon start --autoreload-config"
