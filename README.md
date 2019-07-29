# docker ADITO


## Warning: A valid license for ADITO is necessary to run this image.



## What is ADITO?

ADITO is a powerful CRM software. It´s developed by [ADITO Software GmbH](https://www.adito.de) and written in Java.



## Environment Variables

All possible environment variables with their default values are listed below.


### `JVM_XMX=1024M`

Maximum memory allocation pool for Java (for example 2G = 2 gigabyte).


### `WEBSTART_URL=`

Only necessary when you use https and/or another port than 80.

example: WEBSTART_URL=https://domain.com:8443


### `WEBSTART_HOST=`

Domain name or IP of the docker host used for adito webstart.


### `ADITO_PORT=7779`

This is the port where you can access the ADITO server.


### `ADITO_CONNECTION_TYPE=NETTY`

Normally there is no need to change this connection type between the ADITO client and ADITO server.

Possible values are:
- NETTY
- CLASSIC
- NIO
- STATELESS
- HTTP


### `SRVCONF_DATABASETYP=`

Database type of the System Database

Possible values are:
- 3 (mySQL)
- 7 (Derby)
- 8 (PostgreSQL)
- 12 (MariaDB)


### `SRVCONF_DATABASE=`

Name of the System Database.


### `SRVCONF_HOST=`

Domain Name or IP of the System Database.


### `SRVCONF_PORT=`

Port of the System Database.


### `SRVCONF_USER=`

User for the System Database.


### `SRVCONF_PASSWORD=`

Password of the user for the System Database.


### `SRVCONF_SERVER_ID=`

System ID configured in the ADITO designer.



## Run ADITO

```console
$ docker run -d --name some-mariadb -v /my/own/datadir:/var/lib/mysql -e MYSQL_DATABASE=aditodatabase -e MYSQL_USER=adito -e MYSQL_PASSWORD=secret -e MYSQL_ROOT_PASSWORD=secret2 mariadb:10.1
$ docker run -d --name some-adito -p 7779:7779 -p 8080:80 -e WEBSTART_URL="http://myserver:8080" -e WEBSTART_HOST=myserver -e SRVCONF_DATABASE=aditodatabase -e SRVCONF_DATABASETYP=12 -e SRVCONF_HOST=mariadb -e SRVCONF_PORT=3306 -e SRVCONF_USER=adito -e SRVCONF_PASSWORD=secret -e SRVCONF_SERVER_ID=default -e JVM_XMX=4G --link some-mariadb:mariadb adito/adito
```
