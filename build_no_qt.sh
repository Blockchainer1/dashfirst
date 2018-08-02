dd if=/dev/zero of=/var/swap.img bs=2048k count=1000
mkswap /var/swap.img
swapon /var/swap.img
apt-get install software-properties-common -y
add-apt-repository ppa:bitcoin/bitcoin -y
apt-get update
apt-get install -y libboost-all-dev build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libdb4.8-dev libdb4.8++-dev
./autogen.sh
./configure --without-gui
make
make install
