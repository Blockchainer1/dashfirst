dd if=/dev/zero of=/var/swap.img bs=2048k count=1000
mkswap /var/swap.img
swapon /var/swap.img
apt-get install software-properties-common -y
add-apt-repository ppa:bitcoin/bitcoin -y
apt-get update
apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev  libzmq3-dev curl libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev
./autogen.sh
./configure
make
make install
