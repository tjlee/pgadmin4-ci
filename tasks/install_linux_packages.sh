#!/usr/bin/env bash

# copy utility for pyperclip to work in the test
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt-get update
apt-get install xsel

# update google chrome so it works with new chromedriver
#curl -s https://raw.githubusercontent.com/chronogolf/circleci-google-chrome/master/use_chrome_stable_version.sh | bash

#curl -L -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
#dpkg -i google-chrome.deb;
#sed -i 's|HERE/chrome\"|HERE/chrome\" --disable-setuid-sandbox|g' /opt/google/chrome/google-chrome;
#rm google-chrome.deb

apt-get -y install wget --fix-missing
apt-get -y install xvfb --fix-missing # chrome will use this to run headlessly
apt-get -y install unzip --fix-missing

# install dbus - chromedriver needs this to talk to google-chrome
apt-get -y install dbus --fix-missing
apt-get -y install dbus-x11 --fix-missing
ln -s /bin/dbus-daemon /usr/bin/dbus-daemon     # /etc/init.d/dbus has the wrong location
ln -s /bin/dbus-uuidgen /usr/bin/dbus-uuidgen   # /etc/init.d/dbus has the wrong location

# install chrome
apt-get -y install google-chrome-stable
