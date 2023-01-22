```
podman pull docker.io/edigonzales/postgis:14-3.2
podman pull docker.io/edigonzales/geoserver:2.22.0

podman create -t --pod new:gdi -p 54322:5432 -p 8080:8080 postgis:14-3.2
podman create -t --pod gdi geoserver:2.22.0

podman run -dt --pod new:geoserver -p 8080:8080 geoserver:2.22.0

```

- Achtung: manuell verändertes gdi.yaml: env-var. Sollten beim Erstellen hinzugefügt werden.
- Wie zwei Db mit "gleichem" Port innerhalb Pod? Env-Var? siehe postgres Doku. https://www.postgresql.org/docs/13/app-postgres.html PGPORT
- context.xml bei geoserver wegen db connections? Neu localhost, da innerhalb pod?

- für später: es bräucht sowas wie ein sogis-gdi geoserver-data-dir (wegen namespaces). wie? herunterladen?