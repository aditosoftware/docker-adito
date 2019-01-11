## Warning: A valid license for ADITO is necessary to run this image.



## What is ADITO?

ADITO is a powerful CRM software. It´s developed by [ADITO Software GmbH](https://www.adito.de) and written in Java.



## Environment Variables

All possible environment variables with their default values are listed below.


### `JVM_XMX=1G`

Maximum memory allocation pool for Java (for example 2G = 2 gigabyte; 1024M = 1024 megabyte).


### `SRVCONF_DATABASETYP=`

Database type of the System Database

Possible values are:
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

We provide a [docker-compose.yml](https://raw.githubusercontent.com/aditosoftware/docker-adito/master/docker-compose.yml)
