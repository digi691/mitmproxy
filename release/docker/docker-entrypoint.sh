#!/bin/sh
set -e

if ! whoami &> /dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-mitmproxy}:x:$(id -u):0:${USER_NAME:-mitmproxy} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

MITMPROXY_PATH="$HOME/.mitmproxy"

exec "$@"
