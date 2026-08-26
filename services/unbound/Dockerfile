FROM debian:13-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        dns-root-data \
        unbound \
    && rm -rf /var/lib/apt/lists/* \
    && install -d -o unbound -g unbound /var/lib/unbound \
    && install -o unbound -g unbound -m 0644 \
        /usr/share/dns/root.key \
        /var/lib/unbound/root.key

COPY unbound.conf /etc/unbound/unbound.conf

RUN unbound-checkconf /etc/unbound/unbound.conf

EXPOSE 5335/tcp
EXPOSE 5335/udp

CMD ["unbound", "-d", "-c", "/etc/unbound/unbound.conf"]