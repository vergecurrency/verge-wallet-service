# Verge Wallet Service
This repository contains the automated scripts used to deploy Verge Wallet Service (VWS) to Verge's public servers.

## Development

```bash
$ ./install.sh

$ cd db
$ docker-compose up -d

$ cd ..

$ cd api
$ docker-compose up -d
```

TODO:

* price/IP api
* nginx for price/IP api
* nginx IP for db
* db replicas
* ci deploy
