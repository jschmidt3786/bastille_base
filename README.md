## Status

## Base Template
Bastille Template to add a base set of packages, etc.

## Bootstrap

```shell
bastille bootstrap https://github.com/jschmidt3786/bastille_base
```

## Usage

```shell
bastille template TARGET jschmidt3786/bastille_base
```

** New for 2021-06-13 **
periodic tasks are commented out in the jail, so the host should do something like this:

[ -d /root/scripts ] || mkdir -p /root/scripts
cat << 'EOF' > /root/scripts/jperiodic
#!/bin/sh
for j  in $(bastille list |awk '{print $1}' |grep -v ^JID); do
  echo processing "$1" periodic tasks in jails
  bastille cmd "$j" periodic "$1"
done
EOF
chmod 755 /root/scripts/jperiodic

grep -q jperiodic /etc/crontab || \
echo "
2       3       *       *       *       root    /root/scripts/jperiodic daily
16      4       *       *       6       root    /root/scripts/jperiodic weekly
31      5       1       *       *       root    /root/scripts/jperiodic monthly

" >> /etc/crontab

