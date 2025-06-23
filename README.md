# Tailscale Gateway

## Setup

```sh
echo TS_AUTHKEY=tskey-auth-popopupu... >> .env
echo TS_ROUTES=192.168.xxx.yyy/32 >> .env
echo TS_HOSTNAME=yourhostname >> .env
chmod 600 .env
chmod 755 start.sh
chmod 644 Dockerfile compose.yml
```

## Run

```sh
docker compose up --build -d
```
