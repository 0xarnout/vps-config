resolver 127.0.0.1;

server {
    listen 80;
    listen [::]:80;
    server_name arnoutdegroot.com;

    return 302 http://www.arnoutdegroot.com$request_uri;
}

server {
    listen 80;
    listen [::]:80;

    server_name www.arnoutdegroot.com;

    location / {
        proxy_pass http://172.23.0.3:8080;
        proxy_redirect off;
    }
}
