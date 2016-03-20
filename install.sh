apt-get install git omxplayer -y
git clone git://github.com/rg3/youtube-dl
cd /usr/bin
ln -s /home/pi/RPi-chromium/youtube-dl/youtube_dl/__main__.py youtube-dl
cat >update-youtube.sh <<EOL
#!/bin/sh
file=__main__.py
maxsize=1000
if [ -d /home/pi/RPi-chromium/youtube-dl ]
then
cd /home/pi/RPi-chromium/youtube-dl
git pull
cd youtube_dl
actualsize=$(wc -c "$file" | cut -f 1 -d ' ')
if [ $actualsize -ge $maxsize ]
then
wget -O __main__.py https://raw.githubusercontent.com/rg3/youtube-dl/master/youtube_dl/__main__.py
chmod +x __main__.py
else
echo "main file ok"
fi
else
echo "youtube-dl from github not found"
fi
EOL
chmod +x update-youtube.sh
ln -s /home/pi/RPi-chromium/native/run_omxplayer.py /usr/bin/run_omxplayer.py
mkdir /etc/chromium-browser/native-messaging-hosts
cp /home/pi/RPi-chromium/native/run_omx.json /etc/chromium-browser/native-messaging-hosts/run_omx.json
echo "Done! Now install the RPi-youtube extension."
