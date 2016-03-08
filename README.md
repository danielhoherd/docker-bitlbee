# BitlBee for Docker
Run [BitlBee][] in a Docker container.

## Prerequisites
1. Install [Docker][].

## Building

```
make
```

## Running

```
make run
```

Configs are stored in the docker container at `/var/lib/bitlbee` and `/etc/bitlbee` and on the host in `${HOME}/.bitlbee`

The defult port is `29493`

[bitlbee]: https://www.bitlbee.org/
[docker]: http://docker.io/
