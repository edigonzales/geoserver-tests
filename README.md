# geoserver-tests

## TODO
- Volume für data_dir
- Doku:
 * Import pub-db Volumen from Image

## Mehrere Geometriespalten
Siehe agi_mopublic_pub Grundstücke. Wollen wir ja eh nicht mehr aber falls vorhanden, kann man es im SLD filtern.

## JNDI
Siehe https://github.com/edigonzales/docker-geoserver. Die _context.xml_-Datei wird reingebrannt. Siehe auch die Links wegen Env Vars, um Credentials zu injecten.

## GetFeatureInfo

```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&STYLES&LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=application/json&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2614991.6249525906%2C1235881.6115957745%2C2616919.499340804%2C1237809.4859839883
```

```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&STYLES&LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=text%2Fhtml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2616029.2107360745%2C1220585.024665918%2C2619884.959512502%2C1224440.7734423454
```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fjpeg&TRANSPARENT=true&QUERY_LAYERS=agi%3A2592000_1229000.ch.so.agi.lidar_2019.ndsm_buildings&STYLES&LAYERS=agi%3A2592000_1229000.ch.so.agi.lidar_2019.ndsm_buildings&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=application/json&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2592182.08036496%2C1229049.6447529022%2C2592242.3264395916%2C1229109.890827534


TODO: Raster

Im Featuretype kann man bereits vieles konfigurieren:

- Aliasnamen
- Attribute nicht anzeigen
- Berechnungen mit Attributen (z.B. "true" -> "Ja"). Aufpassen bei "null"-Werten (-> Richtungskerbe? Ist das null oder wird false für null gehalten?)
- Neues Attribute, z.B. für Objektblatt (dynamische Werte werden in den Templates berechnet)

Templates für HTML- und JSON-Output. 




## REST

