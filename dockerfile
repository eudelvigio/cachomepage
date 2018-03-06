FROM alpine:latest
LABEL maintainer="Cacho recacho"
RUN apk update
RUN apk add nginx supervisor && \
    rm -rf /var/lib/apt/lists/*
	
RUN mkdir /run/nginx
#Define the ENV variable
ENV nginx_vhost /etc/nginx/conf.d/default.conf
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisor/supervisord.conf

# Enable php-fpm on nginx virtualhost configuration
COPY default ${nginx_vhost}
RUN echo "" >> ${nginx_conf} && \
    echo "daemon off;" >> ${nginx_conf}
	
#Copy supervisor configuration
COPY supervisord.conf ${supervisor_conf}

# Volume configuration
VOLUME ["/var/www/html"]

# Configure Services and Port
COPY start.sh /start.sh
CMD ["./start.sh"]
