#!/bin/bash


setup_color() {
  # Only use colors if connected to a terminal
  if [ -t 1 ]; then
  	RED=$(printf '\033[31m')
  	GREEN=$(printf '\033[32m')
  	YELLOW=$(printf '\033[33m')
  	BLUE=$(printf '\033[34m')
  	BOLD=$(printf '\033[1m')
  	RESET=$(printf '\033[m')
  else
  	RED=""
  	GREEN=""
  	YELLOW=""
  	BLUE=""
  	BOLD=""
  	RESET=""
  fi
}

fmt_error() {
  echo ${RED}"报错>>>  $@"${RESET} >&2
}

fmt_underline() {
  echo "$(printf '\033[4m')$@$(printf '\033[24m')"
}

fmt_code() {
  echo "\`$(printf '\033[38;5;247m')$@${RESET}\`"
}

update_sourcelist(){
 sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
 sudo cp source-20.list > /etc/apt/sources.list
 sudo apt update
 sudo apt upgrade
 echo "设置apt源为阿里云,成功"
}

command_exists(){
 command -v "$@" >/dev/null 2>&1
}

install_exec(){
  command_exists $1 || {
    echo "开始安装,不存在的命令: " $1 
    sudo apt install $1 >/dev/null 2>&1 || {
	fmt_error "安装失败:"$1
    }
  }
}

install_all(){
 install_exec git
 install_exec nodejs
 install_exec zsh
}


main(){
 setup_color
 update_sourcelist
 install_all
}

main

