#!/bin/bash

# This migration script handles the following procedure.
# 1: Change configuration of bitcore-node & bitcore-wallet-service to new host.
# 2: Turn nodes.
  # * Turn off bitcore-node
  # * Turn off bitcore-wallet-service
# 3: Dump `bws` database on vws2
# 4: Zip dumped database
# 5: Send zip to new server xvg-db-01
# 6: Restore `bws` database on xvg-db-01
# 7: Turn on nodes.
  # * Turn on bitcore-node
  # * Turn on bitcore-wallet-service

DOCKERDB=verge-wallet-service_database_1

# 1: Change configuration of bitcore-node & bitcore-wallet-service to new host.
# First we upload new temp configuration files.
# Then we rename the current configuration files.
# Lastly we rename the new configuration files.
# These new files point to the new db. (xvg-db-01)
scp ./bitcore.config.json $VWS1:/root/bitcore
scp ./config.js $VWS1:/root/bitcore/packages/bitcore-wallet-service

# 2: Turn nodes.
# We turn off bitcore-node, bitcore-wallet-service and the price services on vws1.
ssh $VWS1 'cd /root/bitcore/packages/bitcore-wallet-service && npm stop'
ssh $VWS1 'systemctl stop bitcore-node.service'
ssh $VWS1 'systemctl stop prices.service'

# 3: Dump `bws` database on vws2
ssh $VWS2 'mongodump -d bws'

# 4: Zip dumped database
ssh $VWS2 'tar -zcvf dump.tar.gz dump'

# 5: Send zip to new server xvg-db-01
scp $VWS2:/root/dump.tar.gz . # First to local
scp ./dump.tar.gz $XVGDB01:/home/vegadmin # to new server
ssh $XVGDB01 'tar -xzvf dump.tar.gz' # unzip

# 6: Restore `bws` database on xvg-db-01
ssh $XVGDB01 "docker exec ${DOCKERDB} sh -c 'exec mongorestore --nsInclude \"bws.*\" dump/'"

# 7: Turn on nodes.
# We turn on bitcore-node, bitcore-wallet-service and the price services on vws1.
ssh $VWS1 'systemctl start bitcore-node.service'
ssh $VWS1 'systemctl start prices.service'
ssh $VWS1 'cd /root/bitcore/packages/bitcore-wallet-service && npm start'
ssh $VWS1 'nginx -s reload'
