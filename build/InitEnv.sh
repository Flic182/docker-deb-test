#!/usr/bin/env bash

if [[ "${EXTRA_INSTALLS}" != "" ]]; then
  # Split supplied environment variable into separate values to pass to apt-get install
  INSTALL_PACKAGES=()
  read -ra INSTALL_PACKAGES <<<"${EXTRA_INSTALLS}"

  apt-get update && apt-get install -y "${INSTALL_PACKAGES[@]}" && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
else
  apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
fi
