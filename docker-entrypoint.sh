#!/bin/bash
[[ $DEBUG ]] && set -x

#加密mysql密码
MYSQL_ENCRYPT_PASS=$(${ALTAS_HOME}/bin/encrypt ${MYSQL_PASSWORD})
MYSQL_ROOT_ENCRYPT_PASS=$(${ALTAS_HOME}/bin/encrypt ${MYSQL_ROOT_PASSWORD})

sed -i -e "s/root:rootpass, mysqluser:mysqlpassword/root:${MYSQL_ROOT_ENCRYPT_PASS}, ${MYSQL_USER}:${MYSQL_ENCRYPT_PASS}/g" \
       -e "s/proxy-address = 0.0.0.0:3308/proxy-address = 0.0.0.0:${PORT:-3308}/g" \
       -e "s/admin-username = user/admin-username = ${ADMIN_USER:-user}/g" \
       -e "s/admin-password = pwd/admin-password = ${ADMIN_PASS:-pwd}/g" \
       -e "s/admin-address = 0.0.0.0:2345/admin-address = 0.0.0.0:${ADMIN_PORT:-2345}/g" ${ALTAS_HOME}/conf/test.cnf

[[ $CHARSET ]] && sed -i "s/#charset = utf8/charset = ${CHARSET}/g" ${ALTAS_HOME}/conf/test.cnf
[[ $LOG_LEVEL ]] && sed -i "s/log-level = message/log-level = ${LOG_LEVEL}/g" ${ALTAS_HOME}/conf/test.cnf

[[ $PAUSE ]] && sleep $PAUSE

# mk mysql slave
while true 
do
# start slave 
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -P${MYSQL_SLAVE_PORT} -e "change master to master_host='127.0.0.1', master_port=3306, master_user='root', master_password='${MYSQL_ROOT_PASSWORD}';start slave;"
# check it
mysql -uroot -p${MYSQL_ROOT_PASSWORD} -P${MYSQL_SLAVE_PORT} -e "show slave status\G;" | grep "Slave_IO_Running: Yes"
if [ $? == 0 ];then    
    break
fi
echo "Waiting slave DB init··· retry in 3 seconds" 
sleep 3
done



/usr/local/mysql-proxy/bin/mysql-proxyd test start