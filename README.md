# Overview

Docker Compose for Neo X

Meant to be used with [central-proxy-docker](https://github.com/CryptoManufaktur-io/central-proxy-docker) for traefik
and Prometheus remote write; use `:ext-network.yml` in `COMPOSE_FILE` inside `.env` in that case.

If you want the RPC ports exposed locally, use `rpc-shared.yml` in `COMPOSE_FILE` inside `.env`.

## Quick Start

The `./neoxd` script can be used as a quick-start:

`./neoxd install` brings in docker-ce, if you don't have Docker installed already.

`cp default.env .env`

`nano .env` and adjust variables as needed, particularly `BINARY_URL` and `GENESIS_URL`

`./neoxd up`

## Software update

To update the software, run `./neoxd update` and then `./neoxd up`

The repo supports both local and remote files for `genesis.json` the binary ZIP. Using `https://` or `file://`
it can detect to download the file or use a locally mounted file.

To use a locally mounted file, add the files to `private-config` folder and then set the path as follows.

```properties
GENESIS_URL=file:///tmp/private-config/genesis.json
BINARY_URL=file:///tmp/private-config/geth.zip
```

## Customization

`custom.yml` is not tracked by git and can be used to override anything in the provided yml files. If you use it,
add it to `COMPOSE_FILE` in `.env`

## Version

Neo X Docker uses a semver scheme.

This is Neo X Docker v1.0.0
