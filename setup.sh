#!/bin/bash

# work port
port=10024

function updateYum(){
    yum -y update
}

function checkGit(){
    if type git >/dev/null 2>&1; then 
        return 0 
    else 
        yum install git 
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
    mkdir /data && cd /data && git clone https://github.com/hewei-github/ssr-shell-tools.git
    cd /data/ssr-shell-tools
    echo `randstr` > /data/.password
}

function install(){
    /data/ssr-shell-tools/ss-fly.sh -i $(`cat /data/.password`) ${port}
    /data/ssr-shell-tools/ss-fly.sh -bbr
}

function main(){
    updateYum
    checkGit
    init
}

main
