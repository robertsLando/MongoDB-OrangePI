sudo adduser --ingroup nogroup --shell /etc/false --disabled-password --gecos "" \
--no-create-home mongodb

sudo mkdir /var/log/mongodb
sudo chown mongodb:nogroup /var/log/mongodb

sudo mkdir /var/lib/mongodb
sudo chown mongodb:root /var/lib/mongodb
sudo chmod 775 /var/lib/mongodb

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

sudo systemctl enable mongodb
