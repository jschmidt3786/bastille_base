#!/bin/sh
mkdir -p /usr/local/etc/pkg/repos
echo FreeBSD: \{ url: pkg+http:\/\/pkg.FreeBSD.org\/\$\{ABI\}\/latest, enabled: yes \} > /usr/local/etc/pkg/repos/FreeBSD.conf
env ASSUME_ALWAYS_YES=YES pkg bootstrap
sed -i .bak 's/^#DEFAULT_ALWAYS_YES.*/DEFAULT_ALWAYS_YES\ =\ true;/' /usr/local/etc/pkg.conf
pkg install -y bash bash-completion ccze colordiff htop mc sudo tree vim-console
chsh -s /usr/local/bin/bash
