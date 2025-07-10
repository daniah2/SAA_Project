FROM nginx:latest

COPY index.html /usr/share/nginx/html/
COPY style.css  /usr/share/nginx/html/
COPY script.js  /usr/share/nginx/html/

COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT [ "sh", "-c", "sed -i -e 's|BACKEND_DNS|'$BACKEND_DNS'|g' -e 's|BACKEND_PORT|'$BACKEND_PORT'|g' /etc/nginx/nginx.conf && nginx -g 'daemon off;'" ]