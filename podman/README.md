```
podman pull docker.io/edigonzales/postgis:14-3.2
podman pull docker.io/sogis/postgis:14-3.2
podman pull docker.io/edigonzales/geoserver:2.22.0

podman create -t --pod new:gdi -p 54322:5432 -p 8080:8080 postgis:14-3.2
podman create -t --pod gdi geoserver:2.22.0

podman run -dt --pod new:geoserver -p 8080:8080 geoserver:2.22.0

```

- Achtung: manuell verändertes gdi.yaml: env-var. Sollten beim Erstellen hinzugefügt werden.
- Wie zwei Db mit "gleichem" Port innerhalb Pod? Env-Var? siehe postgres Doku. https://www.postgresql.org/docs/13/app-postgres.html PGPORT
- context.xml bei geoserver wegen db connections? Neu localhost, da innerhalb pod?

- für später: es bräucht sowas wie ein sogis-gdi geoserver-data-dir (wegen namespaces). wie? herunterladen?


```

podman pod create -p 54321:54321 -p 54322:54322 --name gdi-dev
podman create -t --pod gdi-dev -e POSTGRES_DB=edit -e PGPORT=54321 -e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_HOST_AUTH_METHOD=md5 -e PG_WRITE_PWD=ddluser -e PG_READ_PWD=dmluser -e PG_GRETL_PWD=gretl docker.io/edigonzales/postgis:14-3.2
podman create -t --pod gdi-dev -e POSTGRES_DB=pub -e PGPORT=54322 -e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_HOST_AUTH_METHOD=md5 -e PG_WRITE_PWD=ddluser -e PG_READ_PWD=dmluser -e PG_GRETL_PWD=gretl docker.io/edigonzales/postgis:14-3.2
podman create -it --entrypoint bash --pod gdi-dev --name gretl -v /Users/stefan/sources/gretljobs:/home/gradle/project docker.io/sogis/gretl:2.2.295


podman pod start gdi-dev
podman pod stop gdi-dev
podman pod rm gdi-dev

podman exec -it gretl bash

```

todo:

- volumes für db
- gretljobs verzeichnis mounten