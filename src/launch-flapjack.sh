#!/bin/bash

set -e

export PATH=$PATH:/opt/rh/ruby193/root/usr/local/bin

## this will purposely fail if there's no .erb file
if [ ! -e /etc/flapjack/flapjack_config.yaml ]; then
    erb /etc/flapjack/flapjack_config.yaml.erb > /etc/flapjack/flapjack_config.yaml
fi

exec flapjack start
