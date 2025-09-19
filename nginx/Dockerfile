FROM nginx:mainline-bookworm

COPY apt/nginx-archive-keyring.gpg /usr/share/keyrings/nginx-archive-keyring.gpg
COPY apt/nginx.sources /etc/apt/sources.list.d/nginx.sources
RUN apt-get update && apt-get install nginx-module-acme && rm -rf /var/lib/apt/lists/*