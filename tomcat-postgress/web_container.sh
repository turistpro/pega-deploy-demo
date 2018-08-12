#!/bin/bash

name=$1
port=$2

if [ -z "$name" ]; then
  name='pega'
fi

if [ -z "$port" ]; then
  port='8080'
fi

docker_db=$name'_db'
docker_web=$name'_web'

# run web container
docker run -d --name $docker_web -p $port:8080 --link $docker_db:db tomcat:8-jre8-alpine
docker cp postgresql-42.2.1.jar $docker_web:/usr/local/tomcat/lib/
docker cp ./archives/prhelp.war $docker_web:/usr/local/tomcat/webapps/
docker cp ./archives/prsysmgmt.war $docker_web:/usr/local/tomcat/webapps/
docker cp prweb.xml $docker_web:/usr/local/tomcat/conf/Catalina/localhost/
docker cp ./archives/prweb.war $docker_web:/usr/local/tomcat/webapps/
