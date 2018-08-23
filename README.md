# MongoDB-OrangePI

Mongodb 3.2.12 for orange PI precompiled binaries for 32 bit armv7l.

**WARNING**
Mongodb size limit on 32bit systems is 2GB.

### Install

Create mongodb user and folders needed

```bash
sudo adduser --ingroup nogroup --shell /etc/false --disabled-password --gecos "" \
--no-create-home mongodb

sudo mkdir /var/log/mongodb
sudo chown mongodb:nogroup /var/log/mongodb

sudo mkdir /var/lib/mongodb
sudo chown mongodb:root /var/lib/mongodb
sudo chmod 775 /var/lib/mongodb
```

Clone this repo and copy binaries files, configuration and service

```bash
git clone https://github.com/robertsLando/MongoDB-OrangePI.git

cd MongoDB-OrangePI
sudo cp mongodb.conf /etc
sudo cp mongodb.service /lib/systemd/system

cd bin
sudo chown root:root mongo*
sudo chmod 755 mongo*
sudo cp -p mongo* /usr/bin

sudo systemctl start mongodb
sudo systemctl status mongodb
```

Enable mongodb on startup

```bash
sudo systemctl enable mongodb

```

## Fix Mongo if not working

Sometimes mongo could need recovery, run this commands to recover the db

```bash
sudo -u mongodb mongod --repair --dbpath /var/lib/mongodb/
sudo service mongodb restart
```

# Build mongo from source

```bash

#Download mongo
mkdir install
cd install
wget https://fastdl.mongodb.org/src/mongodb-src-r3.2.12.tar.gz
tar xvf mongodb-src-r3.2.12.tar.gz
cd mongodb-src-r3.2.12

##Install required package for compiling
sudo aptitude install scons build-essential
sudo aptitude install libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-thread-dev
sudo aptitude install python-pymongo

#Increese swap space
sudo dd if=/dev/zero of=/mytempswapfile bs=1024 count=524288
sudo chmod 0600 /mytempswapfile
sudo mkswap /mytempswapfile
sudo swapon /mytempswapfile

#Generate additional sources
cd src/third_party/mozjs-38/
./get_sources.sh
./gen-config.sh arm linux
cd -

#Start compiling
scons mongo mongod -j4 --disable-warnings-as-errors --wiredtiger=off --mmapv1=on --warn=no-all

#Strip binaries files to reduce space usage
cd build/opt/mongo
sudo strip mongo*

##Reboot system and remove swap file

sudo reboot
sudo rm -rf /mytempswapfile
```

You will find your compiled binaries on `build/opt/mongo`. Now you can copy your binaries in the `usr/bin` and create the mongodb conf and service file by following [Install](#install) section

### Sources

Thanks to:

- Mongo binaries configuration and service: https://andyfelong.com/2016/01/mongodb-3-0-9-binaries-for-raspberry-pi-2-jessie/
- Mongo binaries compile: http://koenaerts.ca/compile-and-install-mongodb-on-raspberry-pi/
