# MongoDB-OrangePI

Mongodb for orange PI precompiled binaries for 32 bit armv7l

### Installation

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

sudo cp mongodb.conf /etc
sudo cp mongodb.service /lib/systemd/system

cd bin
sudo chown root:root mongo*
sudo chmod 755 mongo*
sudo strip mongo*
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
