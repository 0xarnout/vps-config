# Install nginx

# Setup apt repo for nginx
cp nginx/apt/nginx.sources /etc/apt/sources.list.d/
cp nginx/apt/nginx-archive-keyring.gpg /etc/apt/keyrings/
cp nginx/apt/nginx.preferences /etc/apt/preferences.d/nginx

# Install nginx
apt-get update
apt-get install nginx nginx-acme-module --yes

#
cp nginx/config/nginx.conf /etc/nginx/nginx.conf
cp nginx/config/arnoutdegroot.com /etc/nginx/sites-available/arnoutdegroot.com
unlink /etc/nginx/sites-enabled/default
ln --symbolic ../sites-available/arnoutdegroot.com /etc/nginx/sites-enabled/arnoutdegroot.com

systemctl reload nginx



# Starting blog service (docker install is assumed)

# Generate random 32 byte (256 bit) secrets for database auth
mkdir blog-compose/secrets
chmod 700 blog-compose/secrets
dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 --wrap 0 > blog-compose/secrets/db_password.txt
dd if=/dev/urandom bs=32 count=1 2>/dev/null | base64 --wrap 0 > blog-compose/secrets/db_root_password.txt

# Create directory for uploads
mkdir -p blog-compose/volumes/uploads

## A systemd service should be created to run this service.
## For now, `docker compose up -d` in `blog-compose` should be used.
