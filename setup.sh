set -e

echo "-- Setting dir perms... --"
mkdir -p /var/lib/ee-web-archive
groupadd ee-web-archive-group || true
usermod -a -G ee-web-archive-group "$SUDO_USER"
chown :ee-web-archive-group /var/lib/ee-web-archive
setfacl -dm g:ee-web-archive-group:rwx /var/lib/ee-web-archive
setfacl -m g:ee-web-archive-group:rwx /var/lib/ee-web-archive

echo "-- Creating default dirs... --"
mkdir /var/lib/ee-web-archive/archivee-minimaps

echo "-- Installing gdown... ---"
pip install gdown
echo "-- Downloading sqlite-zstd... --"
gdown 1fJX_baT5lsicIDfcabLkRRrcC5hbmsBc -O /var/lib/ee-web-archive/libsqlite_zstd.so
echo "-- Downloading smiley-player DB... --"
gdown 12ZvgdAZxZHV6sUf-xjLAVgt5gDi-lPRE -O /var/lib/ee-web-archive/smiley.sqlite3
echo "-- Downloading ArchivEE DB... --"
gdown 1M4KEE0K1Ueu0LZq6k2cTEeQVi9bsGMl6 -O /var/lib/ee-web-archive/ArchivEE.sqlite3

echo "-- Reloading user groups... --"
# Hack to reload the user groups. Sorry. Apparently there's no better way to do it on a Linux script.
exec sudo -s -u ${SUDO_USER}