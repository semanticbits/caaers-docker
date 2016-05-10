#!/bin/bash
set -e
cp -R -n $SERVICEMIX_HOME/conf_original/* $SERVICEMIX_HOME/conf/
exec "$@"