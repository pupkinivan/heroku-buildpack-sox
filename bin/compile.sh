#!/bin/sh



# 3 args: BUILD_DIR, CACHE_DIR, ENV_DIR
# BUILD_DIR will be the app's location
# CACHE_DIR contents are persistent
# ENV_DIR contains a file for each of the app's configuration vars


echo "-----> Install SoX"
BUILD_DIR=$1
VENDOR_DIR="vendor"

# DOWNLOAD_URL="http://security.ubuntu.com/ubuntu/pool/universe/s/sox/sox_14.4.2-3ubuntu0.18.04.1_amd64.deb"

DOWNLOAD_URL="http://downloads.sourceforge.net/project/sox/sox/14.4.2/sox-14.4.2.tar.bz2?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsox%2Ffiles%2Fsox%2F14.4.2%2F&ts=1476009578&use_mirror=ufpr"

echo "DOWNLOAD_URL = " $DOWNLOAD_URL | indent

cd $BUILD_DIR
mkdir -p $VENDOR_DIR
cd $VENDOR_DIR
mkdir -p sox
cd sox
curl -L --silent $DOWNLOAD_URL | tar jxf --strip-components=1

cd sox-14.4.2
./configure --prefix=$VENDOR_DIR/sox/ --disable-shared --enable-static
make
make install

echo "exporting PATH" | indent

# DE DONDE SACO .profile.d/ffmpeg.sh??
# Estoy creando el archivo para que se agregue la carpeta al PATH.
PROFILE_PATH="$BUILD_DIR/.profile.d/sox.sh"
mkdir -p $(dirname $PROFILE_PATH)
echo 'export PATH="$PATH:${HOME}/vendor/sox"' >> $PROFILE_PATH