#!/usr/bin/env bash

htdocs="$HOME/nginx"
nginxConfDir="/usr/local/etc/nginx/sites-enabled"
hostsFile="/etc/hosts"

function createDirectory
{
	if [[ ! -e $1 ]]; then
		mkdir "$htdocs/$1"
	fi

	writeMessage "Dictionary '$1' was created"
}

function writeMessage
{
	echo "$1"

	if [[ $2 == true ]]; then
		exit 1
	fi
}

function setChmod
{
	chmod -R $1 $2
}

function getConfig
{
	echo -ne "server { \\r
		listen 80; \\r
		server_name $1.lc; \\r
		root $htdocs/$1/www/; \\r
		\\r
		error_log $htdocs/$1/log/$1_errors.log; \\r
		access_log $htdocs/$1/log/$1_access.log; \\r
		\\r
		include common/common.conf; \\r
		include common/php.conf; \\r
		include common/nette.conf; \\r
	}" 
}

function isRunning
{
	if ps ax | grep -v grep | grep $1 > /dev/null
	then
		echo "1"
	else
		echo "0"
	fi
}

#stop nginx server, if nginx is running
if [ $(isRunning "nginx") = "1" ]; then
	writeMessage "Stop nginx server"
	nginx -s stop
fi

#set name of Host name
echo -n 'Write name of host:'
read hostName

#create dictionary for host in the htdocs
createDirectory $hostName
createDirectory "$hostName/log"
createDirectory "$hostName/www"
setChmod "777" $hostName

writeMessage "Write config to file"
echo $(getConfig $hostName) > "$nginxConfDir/$hostName.conf"

writeMessage "Adding host into $hostsFile"
echo "127.0.0.1 $hostName.lc" >> $hostsFile

writeMessage "Start nginx server"
nginx

