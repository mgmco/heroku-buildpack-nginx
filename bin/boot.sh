#!/usr/bin/env bash

set -e            # fail fast
set -o pipefail   # don't ignore exit codes when piping output
# set -x          # enable debugging

build_dir=$1
cache_dir=$2
env_dir=$3
bp_dir=$(cd $(dirname $0); cd ..; pwd)

# Load some convenience functions like status(), echo(), and indent()
source $bp_dir/bin/common.sh

ruby $HOME/config/htpasswd.rb
erb $HOME/config/nginx.conf.erb > $HOME/config/nginx.conf

status "Showing of nginx.conf"

status "CAT: `cat $HOME/config/nginx.conf`"

cat $HOME/config/nginx.conf

mkdir -p $HOME/logs/nginx
touch $HOME/logs/nginx/access.log $HOME/logs/nginx/error.log

(tail -f -n 0 $HOME/logs/nginx/*.log &)

exec $HOME/vendor/nginx/sbin/nginx -p $HOME -c $HOME/config/nginx.conf
