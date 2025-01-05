#!/bin/bash
set -e

echo "-- Creating default dirs... --"
mkdir -p /var/lib/ee-web-archive/archivee-minimaps

echo "-- Check if files already exist... --"
if [ -f "/var/lib/ee-web-archive/libsqlite_zstd.so" ] && \
   [ -f "/var/lib/ee-web-archive/smiley.sqlite3" ] && \
   [ -f "/var/lib/ee-web-archive/ArchivEE.sqlite3" ]; then
    echo "All files exist. Exiting..."
    exit 0
else
  echo "At least one of the files is missing. Will download all of them."
fi

echo "-- Installing gdown... ---"
pip install gdown
echo "-- Downloading sqlite-zstd... --"
gdown 1fJX_baT5lsicIDfcabLkRRrcC5hbmsBc -O /var/lib/ee-web-archive/libsqlite_zstd.so
echo "-- Downloading smiley-player DB... --"
gdown 12ZvgdAZxZHV6sUf-xjLAVgt5gDi-lPRE -O /var/lib/ee-web-archive/smiley.sqlite3
echo "-- Downloading ArchivEE DB... --"
gdown 1M4KEE0K1Ueu0LZq6k2cTEeQVi9bsGMl6 -O /var/lib/ee-web-archive/ArchivEE.sqlite3
