#!/bin/bash

###############
##  SETTING  ##
###############

DIR=`pwd`
DOWNLOADER="wget"
URL="http://download.sourceforge.net/devkitpro"
#DOWNLOADER="ls -la"
#URL="."
ARCH=`uname -m`
DEVKITARM="devkitARM_r44-${ARCH}-linux.tar.bz2"
DEFAULT_ARM7="default_arm7-0.5.27.tar.bz2"
LIBNDS="libnds-1.5.10.tar.bz2"
LIBFILESYSTEM="libfilesystem-0.9.12.tar.bz2"
LIBFAT="libfat-nds-1.0.14.tar.bz2"
MAXMOD="maxmod-nds-1.0.9.tar.bz2"
DSWIFI="dswifi-0.3.17.tar.bz2"
EXAMPLES="nds-examples-20140401.tar.bz2"

echo "devkitARM NDS installer"
echo "installing to $DIR"

###################
##  DOWNLOADING  ##
###################

mkdir download
cd download
echo "Downloading devkitpro files..."
${DOWNLOADER} ${URL}/${DEVKITARM}
${DOWNLOADER} ${URL}/${LIBNDS}
${DOWNLOADER} ${URL}/${LIBFILESYSTEM}
${DOWNLOADER} ${URL}/${LIBFAT}
${DOWNLOADER} ${URL}/${MAXMOD}
${DOWNLOADER} ${URL}/${DSWIFI}
${DOWNLOADER} ${URL}/${DEFAULT_ARM7}
#${DOWNLOADER} ${URL}/${EXAMPLES}
echo "Downloading devkitpro files - done"
cd ..

####################
##  INSTALLATION  ##
####################

mkdir devkitARM
echo "install devkitARM..."
tar xf download/${DEVKITARM}
echo "install devkitARM - done"
cd devkitARM
echo "install devkitARM/default_arm7..."
tar xf ../download/${DEFAULT_ARM7}
echo "install devkitARM/default_arm7 - done"
cd ..

mkdir libnds
cd libnds
echo "install libnds..."
tar xf ../download/${LIBNDS}
echo "install libnds - done"
echo "install libnds/libfilesystem..."
tar xf ../download/${LIBFILESYSTEM}
echo "install libnds/libfilesystem - done"
echo "install libnds/libfat..."
tar xf ../download/${LIBFAT}
echo "install libnds/libfat - done"
echo "install libnds/maxmod..."
tar xf ../download/${MAXMOD}
echo "install libnds/maxmod - done"
echo "install libnds/dswifi..."
tar xf ../download/${DSWIFI}
echo "install libnds/dswifi - done"
cd ..

#mkdir examples
#cd examples
#echo "install examples..."
#tar xf ../download/${EXAMPLES}
#echo "install examples - done"
#cd ..
#echo "install examples - done"
