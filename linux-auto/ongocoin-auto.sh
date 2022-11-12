#!/bin/bash
wget "https://dl.walletbuilders.com/download?customer=d135531935d1d5775f302b4906a10552810a488f1734462d1d&filename=ongocoin-qt-linux.tar.gz" -O ongocoin-qt-linux.tar.gz

mkdir $HOME/Desktop/OngoCoin

tar -xzvf ongocoin-qt-linux.tar.gz --directory $HOME/Desktop/OngoCoin

mkdir $HOME/.ongocoin

cat << EOF > $HOME/.ongocoin/ongocoin.conf
rpcuser=rpc_ongocoin
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node2.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/OngoCoin/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./ongocoin-qt
EOF

chmod +x $HOME/Desktop/OngoCoin/start_wallet.sh

cat << EOF > $HOME/Desktop/OngoCoin/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
echo Press [CTRL+C] to stop mining.
while :
do
./ongocoin-cli generatetoaddress 1 \$(./ongocoin-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/OngoCoin/mine.sh

exec $HOME/Desktop/OngoCoin/ongocoin-qt &

sleep 15

cd $HOME/Desktop/OngoCoin/

clear

exec $HOME/Desktop/OngoCoin/mine.sh