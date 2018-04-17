#!/bin/sh

if [ -z "$JAVA_HOME" ] ; then
  echo "ERROR: JAVA_HOME is not set" >&2
  exit 1
fi

if [ -z "$ACCEPT_ORACLE_BCLA" ] ; then
  echo "ERROR: ACCEPT_ORACLE_BCLA is not set" >&2
  exit 1
fi

exec $JAVA_HOME/bin/java $@
