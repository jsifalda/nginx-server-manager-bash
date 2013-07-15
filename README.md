#Server manager for nginx hosts

Simple manager for creating and removing hosts from nginx site-enabled

![Terminal](http://projects.jsifalda.name/server-manager/screens/terminal.png "Terminal")

##Before start
1. Download repository (e.g. `git clone https://github.com/jsifalda/nginx-server-manager-bash.git`)
2. Make server manager global! Run command `cp server-manager.sh /usr/local/bin/server-manager
` (Don't forget to have **/usr/local/bin** in your PATH)
3. Set variables (nginxConfDir & hostsFile) in file **server-manager** for your environment
4. Run `sudo server-manager`

##Usage

###Creating host

	sudo server-manager

####Creating host with cloned repository

	sudo server-manager -c <git-repo>

###Removing host

	sudo server-manager -r

####SUDO is required!!