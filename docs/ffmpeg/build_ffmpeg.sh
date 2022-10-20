#!/bin/bash
# License of this script: CC0
# Installation of dependent libraries and softwares is required to use this script
# ex. nasm, yasm, libmp3lame-dev, libopus-dev, libvorbis-dev, libvpx-dev...

set -ex

# setup
temp_dir=$(mktemp -d)

# build openh264
cd $temp_dir
git clone -b v2.2.0 --depth 1 --single-branch https://github.com/cisco/openh264.git
cd openh264
make -j `nproc`
sudo make install
sudo ldconfig

# replace openh264 binary to avoid license problem
cd $temp_dir
curl -o ./libopenh264-2.2.0-linux64.4.so.bz2 -L http://ciscobinary.openh264.org/libopenh264-2.2.0-linux64.6.so.bz2
bunzip2 libopenh264-2.2.0-linux64.4.so.bz2
sudo cp libopenh264-2.2.0-linux64.4.so /usr/local/lib/libopenh264.so.2.2.0
sudo rm /usr/local/lib/libopenh264.a

# build ffmpeg
cd $temp_dir
git clone https://git.ffmpeg.org/ffmpeg.git
cd ffmpeg
git checkout n5.0.1
./configure --enable-libopenh264 --enable-libvorbis --enable-libvpx --enable-gnutls
make -j `nproc`
sudo make install

# cleanup
cd
rm -rf $temp_dir
