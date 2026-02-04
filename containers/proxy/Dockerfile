#╔════════════════════════════════════════════════════════════════════════════════╗
#║                        N01D PROXY CONTAINER                                    ║
#║                   Network Interception Proxy | bad-antics                     ║
#╚════════════════════════════════════════════════════════════════════════════════╝

FROM mitmproxy/mitmproxy:latest

LABEL maintainer="bad-antics"
LABEL description="N01D Proxy - mitmproxy for traffic interception"

CMD ["mitmweb", "--web-host", "0.0.0.0"]
