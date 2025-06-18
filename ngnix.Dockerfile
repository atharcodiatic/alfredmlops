FROM nginx:alpine

WORKDIR /app
EXPOSE 8080

COPY default.conf.tpl /etc/nginx/conf.d/default.conf

# COPY ./static/ /var/www/myapp/static/
# COPY ./media/ /var/www/myapp/media/

CMD ["nginx", "-g", "daemon off;"]


  