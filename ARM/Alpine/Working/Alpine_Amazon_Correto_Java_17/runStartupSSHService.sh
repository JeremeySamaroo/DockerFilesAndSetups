#!/bin/sh
ssh-keygen -A
exec /usr/sbin/sshd -D -e "$@"
service ssh start
service ssh status
