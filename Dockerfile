FROM alpine:latest
ADD files /caddy
EXPOSE 3000
WORKDIR /caddy
ENTRYPOINT ./caddy