#!/bin/bash

sqlite3Version=3.43.1

workingDiredctory=/tmp/setup-custom-py-env
mkdir -p "$workingDiredctory"
cd "$workingDiredctory"

if [[ -e "sqlite-autoconf-3430100.tar.gz" ]]; then
    echo "Sqlite$sqlite3Version already downloaded, using cached download"
else
    echo "downloading Sqlite$sqlite3Version..."
    wget "https://www.sqlite.org/2023/sqlite-autoconf-3430100.tar.gz"
fi


echo "extracting SQLite$sqlite3Version..."
tar xvf "sqlite-autoconf-3430100.tar.gz"

echo "building and installing sqlite$sqlite3Version..."
cd "sqlite-autoconf-3430100"
./configure --enable-shared && make && sudo make install
sudo cp .libs/libsqlite3* /usr/lib/x86_64-linux-gnu/

sudo ldconfig

echo "echo testing new sqlite3 with (python3.11 -c 'import sqlite3')..."
python3.11 -c 'import sqlite3'
