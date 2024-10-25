#!/usr/bin/env bash

BASE_POSTGRES_CONF_FILE="/etc/postgresql/postgresql.conf"
POSTGRES_CONF_FILE_SSL_PARTIAL="$PGDATA/postgresql.conf-ssl-partial"
POSTGRES_CONF_FILE="$PGDATA/postgresql.conf"

echo "Preparing PostgreSQL configuration..."
echo -e "\tBase configuration file: $BASE_POSTGRES_CONF_FILE"

if [ -f "$POSTGRES_CONF_FILE_SSL_PARTIAL" ]; then
  echo -e "\tSSL partial configuration file found."
  if [ ! -f "$BASE_POSTGRES_CONF_FILE" ]; then
    echo -e "\tBase configuration file not found. You should set up one."
    exit 1
  fi

  cat "$BASE_POSTGRES_CONF_FILE" "$POSTGRES_CONF_FILE_SSL_PARTIAL" > "$POSTGRES_CONF_FILE"
  echo -e "\tConfiguration written to $POSTGRES_CONF_FILE"
else
    echo -e "\tSSL partial configuration file not found. It might be in initialization..."
fi
