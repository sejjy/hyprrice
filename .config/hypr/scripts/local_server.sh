#!/usr/bin/env bash

GRN="\033[1;32m\033[0m"
RED="\033[1;31m\033[0m"
GRY="\033[1;30m\033[0m"

echo
echo -e "1. ${GRN} start"
echo -e "2. ${RED} stop"
echo -e "3. ${GRY} status\n"

while true; do
  read -r -p "select an option: " option

  case $option in
  1)
    # apache (httpd.service)
    sudo mkdir -p /run/httpd
    sudo chown http:http /run/httpd

    # mariadb (mariadb.service)
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
