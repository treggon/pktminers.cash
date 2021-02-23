#!/bin/bash

docker build --no-cache -t treggon/annminer:1.0.0 -t treggon/annminer:latest -f AnnMiner/Dockerfile .
