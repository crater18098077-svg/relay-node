FROM debian:bookworm-slim
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates tar \
 && rm -rf /var/lib/apt/lists/* \
 && curl -fsSL https://github.com/SagerNet/sing-box/releases/download/v1.12.10/sing-box-1.12.10-linux-amd64.tar.gz -o /tmp/sb.tar.gz \
 && tar -xzf /tmp/sb.tar.gz -C /tmp \
 && install -m 0755 /tmp/sing-box-1.12.10-linux-amd64/sing-box /usr/local/bin/sing-box \
 && rm -rf /tmp/sb.tar.gz /tmp/sing-box-1.12.10-linux-amd64
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
