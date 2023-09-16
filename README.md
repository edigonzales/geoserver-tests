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
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&STYLES&LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=info_format=application/vnd.ogc.gml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2614991.6249525906%2C1235881.6115957745%2C2616919.499340804%2C1237809.4859839883
```



## REST

