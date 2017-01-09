# zabbix-lvs-status
LVS状态zabbix监控
## 使用说明
* 将lvs_discovery.sh和lvs_status.sh置于/etc/zabbix/scripts/目录下并赋予执行权限
```
[root@localhost ~]# ls -l /etc/zabbix/scripts/
total 8
-rwxr-xr-x 1 root root  628 Jan  9 21:51 lvs_discovery.sh
-rwxr-xr-x 1 root root  828 Jan  9 21:51 lvs_status.sh
```
* 将userparameter_lvs.conf置于/etc/zabbix/zabbix_agentd.d/目录下
```
[root@localhost ~]# ls -l /etc/zabbix/zabbix_agentd.d/
total 4
-rw-r--r-- 1 root root 615 Jan  9 21:51 userparameter_lvs.conf
```
* 为zabbix用户添加sudo权限
```
[root@localhost ~]# visudo
Defaults:zabbix !requiretty
zabbix	ALL=(ALL)	NOPASSWD: /sbin/ipvsadm
```
* 重启zabbix-agent守护进程
```
[root@localhost ~]# service zabbix-agent restart
Shutting down Zabbix agent:                                [  OK  ]
Starting Zabbix agent:                                     [  OK  ]
```
* 在zabbix web导入模板zbx_lvs_templates.xml并关联主机

## 监控项说明
```
ActiveConn     #活动连接数
InActConn      #非活动连接数
CPS            #每秒连接数
InPPS          #每秒的入包个数
OutPPS         #每秒的出包个数
InBPS          #每秒入流量
OutBPS         #每秒出流量
```
