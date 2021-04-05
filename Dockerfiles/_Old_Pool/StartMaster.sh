#!/bin/bash
systemctl start nginx
node /PacketCrypt/pool.js --master
