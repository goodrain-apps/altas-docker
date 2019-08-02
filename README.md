# altas-docker
奇虎360开源的mysql-proxy组件 altas

### 关于仓库的名字
啊啊啊啊啊啊啊，我特么的把人家名字拼错了


### 相关配置与环境变量

目前，atlas 连接主库地址默认为 `127.0.0.1:3306` 从库地址为 `127.0.0.1:3307`

以下设置由环境变量实现

| 选项                | 环境变量设置           | 默认值  |    说明  |
| ------------------- | ---------------------- | ------- | ---- |
| root密码            | ${MYSQL_ROOT_PASSWORD} |         |      |
| 普通用户            | ${MYSQL_USER}          |         |      |
| 普通用户密码        | ${MYSQL_PASSWORD}      |         |      |
| Atlas工作端口       | ${PORT}                | 3308    |      |
| Atlas admin用户     | ${ADMIN_USER}          | user    |      |
| Atlas admin用户密码 | ${ADMIN_PASS}          | pwd     |      |
| Atlas admin端口     | ${ADMIN_PORT}          | 2345    |      |
| 客户端字符          | ${CHARSET}             |         |      |
| 日志级别            | ${LOG_LEVEL}           | message |      |
| 调试模式            | $DEBUG                 | false   | 打印启动脚本执行行 |
| 暂停模式            | $PAUSE                 |         | 指定为数值，将在启动前暂停 |
