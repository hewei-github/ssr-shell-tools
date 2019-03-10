#!/bin/bash

#配置文件
config=/etc/shadowsocks.json

# 停止ss服务
function stop(){
    ssserver -c ${config} -d stop
}

# 启动ss服务
function start(){
   ssserver -c ${config} -d start
}

#重启ss服务 
function restart(){
    ssserver -c ${config} -d restart
}

# 帮助菜单
function help(){
    echo "service for ssr :"
    echo " support command  start,stop,restart"
}

# 主功能
function main() {
    case $1 in 
     start)
        start
     ;;
     stop)
        stop
     ;;
     restart)
        restart
     ;;
     *)
       help
     ;;
     esac
}

main ${*}