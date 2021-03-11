#!/bin/bash -vex
DATE=$(date +%s)
cd ~/.ssh/
cp config config_backup-${DATE}
cat config.base >  config
cat include.d/* >> config
\diff -du config_backup-${DATE} config && \
  rm config_backup-${DATE}
