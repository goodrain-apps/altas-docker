FROM centos:6
WORKDIR /usr/local/mysql-proxy
ADD https://github.com/Qihoo360/Atlas/releases/download/2.2.1/Atlas-2.2.1.el6.x86_64.rpm ./
RUN rpm -i Atlas-2.2.1.el6.x86_64.rpm && rm -rf Atlas-2.2.1.el6.x86_64.rpm && \
    yum makecache fast && \
    yum install mysql -y && \
    yum clean all && \
    rm -rf /var/cache/yum
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ADD test.cnf /usr/local/mysql-proxy/conf/test.cnf
ENV ALTAS_HOME /usr/local/mysql-proxy

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]