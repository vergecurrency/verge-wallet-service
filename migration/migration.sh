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


# 1: Change configuration of bitcore-node & bitcore-wallet-service to new host.
# First we upload new temp configuration files.
# Then we rename the current configuration files.
# Lastly we rename the new configuration files.
# These new files point to the new db. (xvg-db-01)


# 2: Turn nodes.
# We turn off bitcore-node, bitcore-wallet-service and the price services on vws1.


# 3: Dump `bws` database on vws2


# 4: Zip dumped database


# 5: Send zip to new server xvg-db-01


# 6: Restore `bws` database on xvg-db-01


# 7: Turn on nodes.
# We turn on bitcore-node, bitcore-wallet-service and the price services on vws1.
