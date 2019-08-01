FROM centos:6
WORKDIR /usr/local/mysql-proxy
ADD https://github.com/Qihoo360/Atlas/releases/download/2.2.1/Atlas-2.2.1.el6.x86_64.rpm ./
RUN rpm -i Atlas-2.2.1.el6.x86_64.rpm && rm -rf Atlas-2.2.1.el6.x86_64.rpm
CMD [ "sleep"."999999999999" ]