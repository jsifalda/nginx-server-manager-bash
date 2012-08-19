#Server manager for nginx hosts

Simple manager for creating and removing hosts from nginx site-enabled

##Before start
Set variables (htdocs, nginxConfDir, hostsFile) in file __server-manager.sh__ for your configurations

##Usage

###Creating host

	sudo <path-to-project>/server-manager.sh

###Removing host

	sudo <path-to-project>/server-manager.sh -r

**SUDO is required**