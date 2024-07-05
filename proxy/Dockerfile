FROM nginx:1.27.0-alpine

ARG NETWORK

ENV NETWORK=${NETWORK}

COPY nginx.conf /etc/nginx/nginx.conf.template

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
