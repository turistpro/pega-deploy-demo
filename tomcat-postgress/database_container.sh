#!/bin/bash

name=$1
port=$2

if [ -z "$name" ]; then
  name='pega'
fi

docker_db=$name'_db'
docker_data=$name'_data'

# run database container
docker run -d --name $docker_db -v $docker_data:/var/lib/postgresql/data  -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=pega prpc/postgres:9.4-alpine

sleep 10

# create schemas
docker exec -it $docker_db psql -U postgres pega -c 'create schema prpcrules;'
docker exec -it $docker_db psql -U postgres pega -c 'create schema prpcdata;'

# Pega Install
docker run --rm -i -v $(pwd):/dist -v $(pwd)/../postgresql-42.2.1.jar:/usr/local/tomcat/lib/postgresql-42.2.1.jar --link $docker_db:db tomcat:8-jre8-alpine sh << EOF
cd /dist/scripts/
sed -i 's/\(pega.jdbc.driver.jar=\)\(.*\)/\1\/usr\/local\/tomcat\/lib\/postgresql-42.2.1.jar/' setupDatabase.properties
sed -i 's/\(pega.jdbc.driver.class=\)\(.*\)/\1org.postgresql.Driver/' setupDatabase.properties
sed -i 's/\(pega.database.type=\)\(.*\)/\1postgres/' setupDatabase.properties
sed -i 's/\(pega.jdbc.url=\)\(.*\)/\1jdbc:postgresql:\/\/db:5432\/pega/' setupDatabase.properties
sed -i 's/\(pega.jdbc.username=\)\(.*\)/\1postgres/' setupDatabase.properties
sed -i 's/\(pega.jdbc.password=\)\(.*\)/\1postgres/' setupDatabase.properties
sed -i 's/\(rules.schema.name=\)\(.*\)/\1prpcrules/' setupDatabase.properties
sed -i 's/\(data.schema.name=\)\(.*\)/\1prpcdata/' setupDatabase.properties
./install.sh
exit
EOF
