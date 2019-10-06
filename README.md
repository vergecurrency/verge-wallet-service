# Verge Wallet Service
This repository contains the automated scripts used to deploy Verge Wallet Service (VWS) to Verge's public servers.

## Development

```bash
$ cd db
$ docker-compose up -d

$ cd ..

$ cd api
$ docker-compose up -d
```

## Production

See [circle CI configuration](blob/master/.circleci/config.yml)
