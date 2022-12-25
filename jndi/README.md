## Geoserver

Original-Repo forken, damit ARM-Image selber hergestellt werden kann und aktuelle Version.

Fork-Repo: https://github.com/edigonzales/geoserver-docker


```
docker build --build-arg GS_VERSION=2.21.2 -t edigonzales/geoserver-base:2.21.2 .
docker push edigonzales/geoserver-base:2.21.2
```

Achtung: Ich muss das Multi-Arch-tauglich/fähig machen! 

## Docker Compose

```
docker-compose build
docker-compose up
```


## JNDI-Test

1. jdbc.jar muss aus geoserver/lib entfernt werden und in tomcat/lib kopiert werden.
2. context.xml muss mit jndi-Resource angepasst werden. 
3. Siehe Docker Build.


Daten importieren:

```
java -jar /Users/stefan/apps/ili2pg-4.9.1/ili2pg-4.9.1.jar --dbhost localhost --dbport 54322 --dbdatabase pub --dbusr ddluser --dbpwd ddluser --dbschema afu_abbaustellen_pub --createGeomIdx --strokeArcs --defaultSrsCode 2056 --createEnumTabs --createEnumTxtCol --disableValidation --models SO_AFU_ABBAUSTELLEN_Publikation_20221103 --doSchemaImport --import data/ch.so.afu.abbaustellen.xtf
```

JNDI-Name in Geoserver ist `java:comp/env/jdbc/pub`. Siehe _context.xml_.


