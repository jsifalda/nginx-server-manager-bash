#Server manager for nginx hosts

Simple manager for creating and removing hosts from nginx site-enabled

![Terminal](http://projects.jsifalda.name/server-manager/screens/terminal.png "Terminal")

##Before start
Set variables (htdocs, nginxConfDir, hostsFile) in file __server-manager.sh__ for your configurations

##Usage

###Creating host

	sudo <path-to-project>/server-manager.sh

###Removing host

	sudo <path-to-project>/server-manager.sh -r

**SUDO is required**