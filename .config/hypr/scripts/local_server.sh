#!/usr/bin/env bash

grn="\033[1;32m\033[0m"
red="\033[1;31m\033[0m"
gry="\033[1;30m\033[0m"

echo # newline
echo -e "1. ${grn} start"
echo -e "2. ${red} stop"
echo -e "3. ${gry} status\n"

while true; do
  read -r -p "select an option: " option

  case $option in
  1)
    # Apache (httpd.service)
    sudo mkdir -p /run/httpd
    sudo chown http:http /run/httpd

    # MariaDB (mariadb.service)
    sudo mkdir -p /run/mysqld
    sudo chown mysql:mysql /run/mysqld
    sudo chmod 755 /run/mysqld

    # start services
    sudo systemctl restart httpd.service
    sudo systemctl restart mariadb.service

    # display status
    sudo SYSTEMD_COLORS=1 systemctl --no-pager status mariadb.service | cat | head -n 3
    sudo SYSTEMD_COLORS=1 systemctl --no-pager status httpd.service | cat | head -n 3
    exit
    ;;

  2)
    # stop services
    sudo systemctl stop httpd.service
    sudo systemctl stop mariadb.service

    # display status
    sudo SYSTEMD_COLORS=1 systemctl --no-pager status mariadb.service | cat | head -n 3
    sudo SYSTEMD_COLORS=1 systemctl --no-pager status httpd.service | cat | head -n 3
    exit
    ;;

  3)
    # check status
    sudo systemctl status httpd.service
    sudo systemctl status mariadb.service
    exit
    ;;

  *)
    echo -e "\033[1;31mInvalid option\033[0m\n"
    ;;
  esac
done
