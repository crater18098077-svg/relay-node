#!/bin/sh
set -e
if [ -z "$UUID" ]; then echo "UUID env var is required" >&2; exit 1; fi
PORT="${PORT:-10000}"
WS_PATH="${WS_PATH:-/ws}"
cat > /tmp/config.json <<EOF
{
  "log": { "level": "warn" },
  "inbounds": [
    {
      "type": "vless",
      "tag": "vless-in",
      "listen": "0.0.0.0",
      "listen_port": ${PORT},
      "users": [ { "uuid": "${UUID}" } ],
      "transport": { "type": "ws", "path": "${WS_PATH}" }
    }
  ],
  "outbounds": [ { "type": "direct", "tag": "direct" } ]
}
EOF
exec sing-box run -c /tmp/config.json
