resolver 127.0.0.11:53;

acme_issuer letsencrypt {
    uri         https://acme-v02.api.letsencrypt.org/directory;
    contact     contact@arnoutdegroot.com;
    state_path  /var/cache/nginx/acme-certificates;
    accept_terms_of_service;
}

server {
    listen 80;
    listen [::]:80;
    server_name arnoutdegroot.com www.arnoutdegroot.com;

    location /.well-known/acme-challenge {
        return 404;
    }
    location / {
        return 301 https://www.arnoutdegroot.com$request_uri;
    }
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name arnoutdegroot.com;

    acme_certificate letsencrypt;

    ssl_certificate       $acme_certificate;
    ssl_certificate_key   $acme_certificate_key;

    return 301 https://www.arnoutdegroot.com$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name www.arnoutdegroot.com;
    
    acme_certificate letsencrypt;

    ssl_certificate       $acme_certificate;
    ssl_certificate_key   $acme_certificate_key;

    location / {
        proxy_pass http://172.23.0.3:8080;
        proxy_redirect off;
    }
}
