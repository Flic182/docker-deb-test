#!/usr/bin/env bash

# Run custom .deb packages
DEBIAN_FRONTEND=noninteractive dpkg --ignore-depends=amazon-cloudwatch-agent -i /opt/*.deb

exec "${@}"