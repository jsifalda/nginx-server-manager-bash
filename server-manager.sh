#!/usr/bin/env bash

htdocs="$HOME/nginx"
nginxConfDir="/usr/local/etc/nginx/sites-enabled"
hostsFile="/etc/hosts"


function getColor
{
	case $1 in
		"red" )
			echo "1";;
		"green" )
			echo "2";;
	esac

}

function createDirectory
{
	if [[ ! -e $1 ]]; then
		mkdir -p $1
	fi

	writeMessage "Directory '$1' was created"
}

function remove
{
	if [[ $1 != "" || $1 != "." ]]; then

		if [[ -e $1 ]]; then
			rm -r $1
		fi

		writeMessage 'Item '$1' was removed'
	else
		writeMessage 'Access denied'
	fi
}

function writeMessage
{
	if [[ $2 ]]; then
		color=$(getColor "$2")
	else
		color=$(getColor "green")
	fi

	echo "$(tput setaf $color) $1 $(tput sgr0)"
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

function cloneRepo
{
	git clone $1 $2
}

#stop nginx server, if nginx is running
if [ $(isRunning "nginx") = "1" ]; then
	writeMessage "Stop nginx server"
	nginx -s stop
fi

#set name of Host name
echo -n 'Write name of host:'
read hostName

if [[ $1 = "-r" ]]; then
	
	writeMessage "Removing server files"
	remove "$htdocs/$hostName"

	writeMessage "Removing server host"
	remove "$nginxConfDir/$hostName.conf"

	writeMessage "Removing host from $hostsFile"
	string="127.0.0.1 $hostName.lc"
	sed "/$string/d" $hostsFile > 'hosts.temp'
	mv "hosts.temp" $hostsFile

else
	#create dictionary for host in the htdocs
	createDirectory $hostName

	if [[ $1 = '-c' && $2 != '' ]]; then
		writeMessage "Cloning github repository"
		cloneRepo $2 "$htdocs/$hostName"
	fi
	
	createDirectory "$htdocs/$hostName/log"
	createDirectory "$htdocs/$hostName/www"

	setChmod "777" "$htdocs/$hostName"

	writeMessage "Write config to file"
	echo $(getConfig $hostName) > "$nginxConfDir/$hostName.conf"

	writeMessage "Adding host into $hostsFile"
	echo "127.0.0.1 $hostName.lc" >> $hostsFile
fi

writeMessage "Start nginx server"
nginx

