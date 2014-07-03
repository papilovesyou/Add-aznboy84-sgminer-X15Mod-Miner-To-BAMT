#!/bin/sh
mine stop
sleep 5
cd /opt/miners/
git clone -b v5_0-x15 https://github.com/aznboy84/sgminer sgminer-x15mod
cd /opt/miners/sgminer-x15mod
cp /opt/miners/sgminer-4.1.0-sph/ADL_SDK/* /opt/miners/sgminer-x15mod/ADL_SDK/
make clean
sleep 5
chmod +x autogen.sh
./autogen.sh
sleep 2
CFLAGS="-O2 -Wall -march=native -I /opt/AMDAPP/include/" LDFLAGS="-L/opt/AMDAPP/lib/x86" ./configure --enable-opencl
sleep 5
make install
sleep 5
clear
cp example.conf /etc/bamt/aznboy84-x15mod.conf
cd /etc/bamt/
patch /etc/bamt/bamt.conf <<.
116a117
>   cgminer_opts: --api-listen --config /etc/bamt/aznboy84-x15mod.conf
124a127
>   # anzboy84 X15 Bitblock "BBL"
129a133
>   miner-aznboy84-x15mod: 1
.
patch /opt/bamt/common.pl <<.
1477a1478,1480
>       } elsif (\${\$conf}{'settings'}{'miner-aznboy84-x15mod'}) {
>         \$cmd = "cd /opt/miners/sgminer-x15mod/;/usr/bin/screen -d -m -S sgminer-x15 /opt/miners/sgminer-x15mod/sgminer \$args";
>         \$miner = "sgminer-x15";
.
cd /etc/bamt/
patch /etc/bamt/aznboy84-x15mod.conf <<.
22c22
< "kernel" : "ckolivas,ckolivas,ckolivas",
---
> "kernel" : "bitblock",
37,39c37,39
< "api-listen" : false,
< "api-mcast-port" : "4028",
< "api-port" : "4028",
---
> "api-listen": true,
> "api-port": "4028",
> "api-allow": "W:127.0.0.1",
> 
.
echo 'aznboy84 Miner Installed.'
echo 'Please review your /etc/bamt/bamt.conf to enable.'
echo 'Configure /etc/bamt/aznboy84-x15mod.conf with pool'
