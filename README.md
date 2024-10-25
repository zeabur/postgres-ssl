# SSL-enabled Postgres DB image

This repository contains the logic to build SSL-enabled Postgres images. It is based on [Railway's work](https://github.com/railwayapp-templates/postgres-ssl).

[![Deploy on Zeabur](https://zeabur.com/button.svg)](https://zeabur.com/templates/QDRPA5)

### Why though?

The official Postgres image in Docker hub does not come with SSL baked in.

Since this could pose a problem for applications or services attempting to connect to Postgres services, we decided to roll our own Postgres image with SSL enabled right out of the box.

### How does it work?

The Dockerfiles contained in this repository start with the official Postgres image as base.  Then the `init-ssl.sh` script is copied into the `docker-entrypoint-initdb.d/` directory to be executed upon initialization.

### Certificate expiry

By default, the cert expiry is set to 820 days. You can control this by configuring the `SSL_CERT_DAYS` environment variable as needed.

### Certificate renewal

When a redeploy or restart is done the certificates expiry is checked, if it has expired or will expire in 30 days a new certificate is automatically generated.
