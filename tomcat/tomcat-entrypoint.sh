#!/bin/bash
set -e
cp -R -n $CATALINA_HOME/conf_original/* $CATALINA_HOME/conf/
exec "$@"