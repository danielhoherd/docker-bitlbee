#! /usr/bin/env bash

# Options.

# Create default config if it doesn't exist
if [ ! -f "/etc/bitlbee/bitlbee.conf" ]; then
  mkdir -p "/etc/bitlbee"
  cp /bitlbee.conf.default /etc/bitlbee/bitlbee.conf
fi

# Make sure $DATADIR is owned by bitlbee user. This effects ownership of the
# mounted directory on the host machine too.
chown -R bitlbee:bitlbee /var/lib/bitlbee /var/run/bitlbee

# Start bitlbee.
exec /usr/sbin/bitlbee -D -n -v
