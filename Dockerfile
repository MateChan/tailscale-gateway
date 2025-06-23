FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y  curl ca-certificates gnupg
RUN curl -fsSL https://tailscale.com/install.sh | sh
COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
