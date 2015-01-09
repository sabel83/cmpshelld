#!/bin/bash
#
# Deployment script of the online Metashell and Preshell demos
# Copyright (C) 2015, Abel Sinkovics (abel@sinkovics.hu)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Config
SHELL_USER=nobody
DIR=/usr/local/share/shell_demo

# Stop the demo if it is running
sudo /etc/init.d/preshell stop
sudo /etc/init.d/metashell stop
sudo /etc/init.d/shell_demo stop
sudo rm -rf "${DIR}"

# Create the demo's directory
sudo mkdir -p "${DIR}"
sudo chown "${SHELL_USER}" "${DIR}"

# Install dependencies
sudo apt-get -y install \
  git \
  cmake \
  make \
  gcc \
  g++ \
  libboost-dev \
  libboost-test-dev \
  libboost-program-options-dev \
  libboost-wave-dev \
  libboost-system-dev \
  libboost-thread-dev \
  libboost-filesystem-dev \
  libboost-regex-dev \
  libreadline-dev \
  shellinabox \
  unzip

# Install the daemons
mkdir bin
cd bin
cmake .. && sudo make install
cd ..

# Start the daemons
sudo /etc/init.d/preshell start
sudo /etc/init.d/metashell start
sudo /etc/init.d/shell_demo start

