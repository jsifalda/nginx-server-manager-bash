#Server manager for nginx hosts

Simple manager for creating and removing hosts from nginx site-enabled

![Terminal](http://projects.jsifalda.name/server-manager/screens/terminal.png "Terminal")

##Before start
####Download repository 
(e.g. `git clone https://github.com/jsifalda/nginx-server-manager-bash.git`)
####Make server manager global! 
Run command `cp server-manager.sh /usr/local/bin/server-manager` 
(Don't forget to have **/usr/local/bin** in your PATH)
####Set variables
(nginxConfDir & hostsFile) in file **server-manager** for your environment
####Run forest, run! 
`sudo server-manager`

##Usage (`SUDO` is required!)

###Creating host

	sudo server-manager

####Creating host with cloned repository

	sudo server-manager -c <git-repo>

###Removing host

	sudo server-manager -r
