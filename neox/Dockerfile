ARG BINARY_URL
ARG GENESIS_URL

FROM alpine:3

RUN apk update && apk add --no-cache ca-certificates tzdata bash wget unzip

RUN mkdir -p /var/lib/neox
RUN bash <<EOF
set -euo pipefail
__binary_url="${BINARY_URL}"
# wget requires special recompile to support file://, instead just check
if [[ "\$__binary_url" = file://* ]]; then
  __local_path="\${__binary_url#file://}"
  cp "\$__local_path" /tmp/geth.zip
else
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
