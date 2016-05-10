# Building the containers

## Building Ubunut OS container 
 
 docker build -t caaers:ubuntu --force-rm ./ubuntu/
 
## Building Java container
 
 docker build -t caaers:java --force-rm ./java/

## Building Tomcat webapp container 
Next is building the tomcat container, before proceeding create the datasource.properties and csm_jaas.config file from provided templates. 
You must only change the DATABASE username and DATABASE password, all the rest are pre-configured. 

 docker build -t caaers:tomcat --force-rm ./tomcat/

## Building ServiceMix container 

Before proceeding, you must create appropriate caxchange.properties from the templates provided. You have to verify and change the AdEERS URL, usernames and password. The hostnames "dbhost" and "tomcat" will get added into /etc/hosts file at container run time. 
	
	docker build -t caaers:servicemix --force-rm ./servicemix/

 
# Running Tomcat 

Before running you must mount the logs folder, which is in the host as "$CATALINA_HOME/logs" . In windows box the HOSTIP script below will not work so no need to run that, instead replace the ${HOSTIP} with the correct IP address of your database server. 

	HOSTIP=`ip -4 addr show scope global dev eth0 | grep inet | awk '{print \$2}' | cut -d / -f 1`
	docker run -p 8080:8080 -d --volume=/c/Users/bj/caaers-config/tomcat/logs:/usr/local/tomcat/logs --volume=/c/Users/bj/caaers-config/tomcat/conf:/usr/local/tomcat/conf  --add-host=dbhost:${HOSTIP} --add-host=servicemix:${HOSTIP} caaers:tomcat 
	

# Running Servicex
Before running you must mount the data & conf folder, which is in the host as "$SERVICEMIX_HOME/" . In windows box the HOSTIP script below will not work so no need to run that, instead replace the ${HOSTIP} with the correct IP address of your database server. 

	HOSTIP=`ip -4 addr show scope global dev eth0 | grep inet | awk '{print \$2}' | cut -d / -f 1`
	docker run -p 8196:8196 -p 7700:7700 -p 6611:6611 -p 61616:61616 -d --volume=/c/Users/bj/caaers-config/smx/data:/usr/local/servicemix/data --volume=/c/Users/bj/caaers-config/smx/conf:/usr/local/servicemix/conf --add-host=dbhost:${HOSTIP} --add-host=tomcat:${HOSTIP} caaers:servicemix

*******************************************************************************************************
Some useful commands
*******************************************************************************************************
Remove unwanted images
 - docker images -a | grep 'none'| awk '{print $3}' | xargs --no-run-if-empty docker rmi

Remove unwanted processes
 - docker ps -a | grep 'Exited' | awk '{print $1}' | xargs --no-run-if-empty docker rm

To connect to tomcat process
- docker exec -i -t <container-id> bash

To stop all processes
 - docker stop $(docker ps -a -q)