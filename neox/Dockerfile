FROM alpine:3

ARG BINARY_URL
RUN apk update && apk add --no-cache ca-certificates tzdata bash wget unzip

COPY geth.zip /tmp/

RUN mkdir -p /var/lib/neox
RUN bash <<EOF
set -euo pipefail
__binary_url="${BINARY_URL}"
if [ -n "\$__binary_url" ]; then
  wget "\$__binary_url" -O /tmp/geth.zip
fi
unzip -d /usr/local/bin /tmp/geth.zip
mv /usr/local/bin/geth* /usr/local/bin/geth
EOF

# Cannot assume buildkit, hence no chmod
COPY ./docker-entrypoint.sh /usr/local/bin/
# Belt and suspenders
RUN chmod -R 755 /usr/local/bin/*

ENTRYPOINT ["geth"]
