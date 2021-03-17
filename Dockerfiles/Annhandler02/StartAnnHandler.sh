#!/bin/bash
systemctl start nginx
./target/release/packetcrypt ah --config pool.toml ah0
