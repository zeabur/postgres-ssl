#syntax=docker/dockerfile:1

ARG POSTGRES_VERSION=17
FROM postgres:${POSTGRES_VERSION}

# Install OpenSSL and sudo
RUN apt-get update && apt-get install -y openssl sudo

# Allow the postgres user to execute certain commands as root without a password
RUN echo "postgres ALL=(root) NOPASSWD: /usr/bin/mkdir, /bin/chown, /usr/bin/openssl" > /etc/sudoers.d/postgres

# Add init scripts while setting permissions
COPY --link --chmod=755 init-ssl.sh /docker-entrypoint-initdb.d/init-ssl.sh
COPY --link --chmod=755 wrapper.sh /usr/local/bin/wrapper.sh
COPY --link --chmod=755 write-config.sh /usr/local/bin/write-config.sh

ENTRYPOINT ["wrapper.sh"]
CMD ["postgres", "--port=5432"]
