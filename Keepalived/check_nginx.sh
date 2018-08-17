#!/bin/bash  
#代码一定注意空格，逻辑就是：如果nginx进程不存在则启动nginx,如果nginx无法启动则kill掉keepalived所有进程  
A=`ps -C nginx --no-header |wc -l`  
if [ $A -eq 0 ];then  
  /etc/init.d/keepalived restart
  echo "start nginx" >> /home/tvtadmin/check_nginx.log
  /usr/sbin/nginx  
  sleep 3  
  if [ `ps -C nginx --no-header |wc -l` -eq 0 ];then  
    echo "stop keepalived" >> /home/tvtadmin/check_nginx.log
    killall keepalived  
  fi  
fi  