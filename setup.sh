#!/bin/bash

# work port
port=10024

function updateYum(){
    yum -y update
}

function checkCommand(){
    if type git >/dev/null 2>&1; then 
        echo "git exists"
    else 
        yum install -y git 
    fi
    if type vim >/dev/null 2>&1; then 
        echo "vim exists"
    else 
        yum install -y vim 
    fi
}

function randstr() {
  index=0
  str=""
  for i in {a..z}; do arr[index]=$i; index=`expr ${index} + 1`; done
  for i in {A..Z}; do arr[index]=$i; index=`expr ${index} + 1`; done
  for i in {0..9}; do arr[index]=$i; index=`expr ${index} + 1`; done
  for i in {1..20}; do str="$str${arr[$RANDOM%$index]}"; done
  echo $str
}

function init(){
    if [ ! -d "/data/" ];then
        mkdir /data && chmod 755 /data 
        cd /data && git clone https://github.com/hewei-github/ssr-shell-tools.git
        cd /data/ssr-shell-tools
    fi    
    echo `randstr` > /data/.password
    echo "init ok"
}

function install(){
    
    if type ssserver > /dev/null 2>&1 ; then
        echo "ssr  installed"
    else
        echo "start install ..." 
        pwd=`cat /data/.password`
        /data/ssr-shell-tools/ss-fly.sh -i ${pwd} ${port}
        /data/ssr-shell-tools/ss-fly.sh -bbr
    fi
}

function main(){
    updateYum
    checkCommand
    init
    install
}

main
