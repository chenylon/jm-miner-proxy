FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y curl
RUN apt-get install -y libpcre3-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y make
RUN apt-get install -y build-essential libtool libpcre3 libpcre3-dev zlib1g-dev openssl libssl-dev

RUN wget https://nginx.org/download/nginx-1.19.0.tar.gz
RUN tar zxvf nginx-1.19.0.tar.gz

RUN cd nginx-1.19.0 \
  &&./configure --with-stream --prefix=/usr/local/nginx --with-http_ssl_module \
  && make \
  && make install

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

RUN echo "daemon off;" >> /usr/local/nginx/conf/nginx.conf
ENV PATH /usr/local/nginx/sbin:$PATH

COPY install-release.sh /usr/local/install-release.sh
RUN bash /usr/local/install-release.sh
COPY server.json /usr/local/etc/v2ray/server.json

EXPOSE 5518

CMD v2ray -c /usr/local/etc/v2ray/server.json & nginx 
