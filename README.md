# geoserver-tests

## TODO
- Volume für data_dir
- Doku:
 * Import pub-db Volumen from Image

## Workspaces

GetCapabilities:
- Mir noch nicht klar, ob man im GetCapabilities die Namespaces entfernen kann.
  * Soweit ich es verstehe, geht das nicht. Sie können entfernt werden im virtuellen Service. (Settings -> enabled ...)
- GetMap funktioniert ohne diese.
- Sonst ch.so.agi etc. als Namespace, damit man noch sortieren kann und es keine Redundanz im Layernamen gibt. 

Data directory:
- Was ist gekapselt an den Workspace? Was ist gekapselt an den Featuretype?

## Mehrere Geometriespalten
Siehe agi_mopublic_pub Grundstücke. Wollen wir ja eh nicht mehr aber falls vorhanden, kann man es im SLD filtern.

## JNDI
Siehe https://github.com/edigonzales/docker-geoserver. Die _context.xml_-Datei wird reingebrannt. Credentials können als Env Vars injected werden. Dazu muss Tomcat mit `-Dorg.apache.tomcat.util.digester.PROPERTY_SOURCE=org.apache.tomcat.util.digester.EnvironmentPropertySource` (siehe Dockerfile) gestartet werden.

## GetFeatureInfo

Im Featuretype kann man bereits vieles konfigurieren:

- Aliasnamen
- Attribute nicht anzeigen
- Berechnungen mit Attributen (z.B. "true" -> "Ja"). Aufpassen bei "null"-Werten (-> Richtungskerbe? Ist das null oder wird false für null gehalten?)
- Neues Attribute, z.B. für Objektblatt (dynamische Werte werden in den Templates berechnet). Oder aber man kann direkt im Featuretype auf Werte zurückgreifen (Link zu Intercapi).
- Raster: Hier wird es bissle frickliger. Man könnte mit Rastertemplates arbeiten resp. man muss ColorMaps verwendend und dann mit dem Custom Name arbeiten. Oder man missbraucht den Bandnamen (der aber keine Leerzeichen und Sonderzeichen erlaubt).

Templates für HTML- und JSON-Output sorgen für den Rest. In einem Web GIS Client würde wohl der JSON-Output zum Zuge kommen, da dort die Geoemtrie drin steckt. D.h. der Client muss mittels Javascript das JSON zu HTML rendern. 

**Achtung:**
- Die Templates wirken immer auf das "normale" GetFeatureInfo. Nicht nur auf die Objektabfrage im Web GIS Client (so wie heute).
- Die Aliasnamen sind nicht Aliasnamen, sondern überschreiben die eigentlichen Attributnamen. D.h. WFS-/XML-Output ist dann oftmals Geschichte, weil nicht mehr wohlgeformed. D.h. FeatureInfo-Output muss JSON oder HTML sein. Für Dataservices muss ebenfalls ein "data"-Featuretype publiziert werden (analog wie heute)

Verbesserungen Prototyp:
- Makros (gibt es glaub) für die Rechnerei des Klick-Punktes
- Datumformatierung: Überlegen, ob immer direkt beim Featurtype und nichts mehr im Template machen. Beim Featuretype weiss man m.E. besser was man hat (Timestamp, nur Datum, ...)

Verbesserungen Geoserver:
- Reihenfolge ändern (drag n drop)
- Nicht löschen, sondern disablen
- JSON-Datentyp für GetFeatureInfo (GeoServer sieht nur String)


**TODO**: Idee Custom Layerinfo: Statischer Methodenaufruf im GeoJson-Template. Die Methode liefert html und map mit Werten zurück. Dann kann immer gewählt werden, ob html oder die Werte vom Web GIS Client gerendert werden. Die Werte sind in den Standard-Properties. Das html ist escaped in einem Root-Feld (wie der Titel).


### Zusätzlicher HTML-Link 
Ausgangslage:
- siehe Intercapi-Link
- Heute ein zusätzliches Jinja-Template

Lösung:
- Dem FeaturType ein zusätzliches Attribut hinzufügen.
- Basis-Url ist statisch und für den EGRID kann man auf das EGRID-Attribut zugreifen.
- Datentyp "String"
- Im HTML-Template wird alles mit "http[s]" zu einem Link gemacht.

Beispiel:
```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Amopublic_grundstueck&STYLES&LAYERS=agi%3Amopublic_grundstueck&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=text%2Fhtml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2596123.0371667286%2C1225519.1819063514%2C2596364.021465255%2C1225760.1662048781
```

### Objektblatt
Ausgangslage:
- siehe Objektblatt bei den Kantonsgrenzzeichen
- Wird heute im SIMI konfiguriert

Lösung:
- Ähnlich wie Zusätzlicher HTML-Link
- Im Template muss jedoch gerechnet werden, um Klickpunkt zu eruieren und als Query-Parameter dem Objektblattaufruf zu übergeben.

**Achtung:** Die Berechnung von x/y stimmt nur für ol3-Beispiele. Dieses komische 100 Pixel und 50 Pixel Konstrukt ist nicht generisch. Ggf. ein Grund mehr auch diese Rechnerei in eine statische Methode auszulagern: getXYFromRequest().

Beispiel:

HTML:
```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&STYLES&LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=text%2Fhtml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2616029.2107360745%2C1220585.024665918%2C2619884.959512502%2C1224440.7734423454
```

JSON:
```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&STYLES&LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=application/json&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2614991.6249525906%2C1235881.6115957745%2C2616919.499340804%2C1237809.4859839883
```

### Darstellen von Fotos
Ausgangslage:
- siehe Kunstbauten
- Beispiel hier mit Kantonsgrenzzeichen

Lösung:
- Wird im HTML-Template gelöst (if/else jpg, png und trallala)

Beispiel:
```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&STYLES&LAYERS=agi%3Ainvntr_hhtsgrnzen_kantonsgrenzstein&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=text%2Fhtml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2616029.2107360745%2C1220585.024665918%2C2619884.959512502%2C1224440.7734423454
```

### Spezielles Template (inkl. JSON-Objekte)

Ausgangslage:
- siehe Sondernutzungspläne

Lösung:
- Template für Layer erstellen.
- Template liegt bei Layer (Featuretype)
- Template hat Einfluss auf normales GetFeaturInfo (nicht nur im Web GIS Client)
- Nicht ganz identisch zur heutigen Lösung. Die RRB werden einzeln gelistet. Nicht gruppiert.
- Achtung: Ein paar Edgecases wurde ignoriert (e.g. kein Titel, nur ein Dokument etc.). Bei dienen fliegt es noch um die Ohren.


Beispiel:
```
http://localhost/geoserver/arp/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=arp%3Ach.so.arp.nutzungsplanung.sondernutzungsplaene&STYLES&LAYERS=arp%3Ach.so.arp.nutzungsplanung.sondernutzungsplaene&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=text%2Fhtml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2596890.258904044%2C1226760.8845875326%2C2596920.38194136%2C1226791.0076248485
```

### Automatisch JSON 

Ausgangslage:
- siehe AV-Mutationen. 
- Beispiel hier mit NPL-Grundnutzung.

Lösung:
- JSON-Handling in unserem Root-Template, also für Anwender unsichtbar und er muss nichts machen.

Herausforderung:
- Einen wirklichen JSON-Typ kennt Geoserver nicht. Ist ein String. Handling muss alles in Freemarker gemacht werden.
- Wird somit schwierig zu erkennen im Template.
- starts_with("[{\"") etc.
- Man könnte eventuell auch eine JSON-Utility-Klasse schreiben und bereitstellen. Man spart sich dabei vielleicht Code (z.B. keine Unterscheidung Objekt vs Liste).

### Fall Pythonmodul

Kann m.E. gleich gelöst werden wie der Fall "SQL-Query". Muss Interface implementieren (bei Bedarf abstrakte Klasse erweitern): Methodensignatur und Rückgabewert. Ein Repo mit den Java-Modulen, die dann für das neue Int-Deployment reingebrannt werden (das neue Int-Deployment muss nicht super schnell sein, da Dev-Deployment funktinioniert).

https://github.com/sogis/layerinfo_modules/blob/master/heatdrill/src/heatdrill/layer_info.py

### Fall SQL-Query

**Achtung:**: Im Dockerfile steht `-Dorg.geoserver.htmlTemplates.staticMemberAccess=*"`. So sind alle statischen Methoden verfügbar. 

Ausgangslage:
- Es soll beliebiges SQL ausgeführt werden können. Input sind die geklickten Koordinaten.
- Z.B. heute bei den Fixpunkten.

Lösung:
- Eigener Java-Code, der eine SQL-Query (aus einer Datei) liest und ausführt.
- Connections von JNDI (Funktioniert auch beim Entwickeln)
- Rückgabewert List<Map<String,Object>>
- Geometrieattribut muss immer "geometrie" heissen und ist GeoJSON
- Beispiel ist für HTML-Template. Ich denke, sinnvoller wäre es auf JSON-Templates zu setzen, da dann nur einmal mit der Formatierung gekämpft werden muss.
- Das Template ist fast generisch, nur der Methodenaufruf muss geändert werden mit dem Namen des Layers. D.h. ist also doch bissle copy/paste.
- Die SQL-Datei liegt im Data-Directory unter einem neuen Verzeichnis "layerinfo_sql".
- Java-Abhängigkeiten: Java-pur. Falls 3rd party libs, müssen diese auch deployed werden. Kann zu Konflikten führen.
- Bringt es etwas, wenn man das gleicn Datenmodell (für die Templates) wie GeoServer verwenden würde (wo finde ich diese?)?. 

SQL:
```
SELECT
    hoehe,
    punktzeichen_txt AS "Punktzeichen",
    typ_txt AS "Kategorie",
    nummer as "Fixpunktnummer",
    ST_X(geometrie) AS "Ost",
    ST_Y(geometrie) AS "Nord",
    t_id AS t_id,
    ST_AsGeoJSON(geometrie) AS geometrie
FROM
    agi_mopublic_pub.mopublic_fixpunkt
WHERE 
    ST_Intersects(geometrie, ST_Buffer(ST_GeomFromText('POINT(:x :y)', 2056), :resolution * :TOLERANCE_IN_PIXEL))
```

Beispiel:
```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Ach.so.agi.av.fixpunkte&STYLES&LAYERS=agi%3Ach.so.agi.av.fixpunkte&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=text%2Fhtml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2596897.7081112145%2C1225435.868221151%2C2597138.6924097408%2C1225676.8525196777
```

## Zeilen filtern

Beispiel "Sondernutzungspläne" (ch.so.arp.nutzungsplanung.sondernutzungsplaene).

QML: 
```
<rules key="{3ba25132-e4de-47d7-87d9-45e48a5ceb8e}">
    <rule scalemaxdenom="39000" filter=" &quot;typ_code_kt&quot; = '610' AND  &quot;rechtsstatus&quot; = 'inKraft'   AND  (&quot;publiziertab&quot; &lt;= to_date(now()))" key="{5364eb01-c5fc-4a82-833d-c120da841c9b}" symbol="0" scalemindenom="1" label="Perimeter kantonaler Nutzungsplan"/>
    <rule scalemaxdenom="39000" filter=" &quot;typ_code_kt&quot; = '611' AND  &quot;rechtsstatus&quot; = 'inKraft'   AND  (&quot;publiziertab&quot; &lt;= to_date(now()))" key="{1e5a550d-b85c-4423-aa12-b0100d1aef94}" symbol="1" scalemindenom="1" label="Perimeter kommunaler Gestaltungsplan"/>
    <rule scalemaxdenom="39000" filter=" &quot;typ_code_kt&quot; = '620' AND  &quot;rechtsstatus&quot; = 'inKraft'   AND  (&quot;publiziertab&quot; &lt;= to_date(now()))" key="{424ce0e7-1956-4c9e-80f2-dcb46d98f0bf}" symbol="2" scalemindenom="1" label="Perimeter Gestaltungsplanpflicht"/>
</rules>
```

In GeoServer als Layereigenschaft ("Restrict the features on layer by CQL filter"):

```
typ_code_kt IN ('610', '611', '620') AND rechtsstatus = 'inKraft' AND publiziertab < now()
```

Das `now()` habe ich überprüft mit der Strasse auf den Grenchenberg. Das Datum auf irgendwas in der Zukunft gesetzt und die Strasse erschien nicht mehr.

## Schemanamen ändern / umhängen
- v1 -> v2 aber gleiche Layerdefinitionen?
- Die gehen verloren, wenn man im Store das Schema ändert, auch wenn die Tabellennamen identisch sind? Man kann aber im XML einfach umhängen?

## SQL View
- Man kann eine beliebige View definieren.
- Wird aber nicht persistiert in der DB, sondern ist eher eine "Virtuelle Tabelle".
- Öffnet natürlich Tür und Tor für allerlei Schabernack.
- Könnte man erlauben für Spezialfälle **ABER** !!!! nur innerhalb der Tabelle oder maximal Schema.

## Format-Output Restrictions
- Siehe WMS-Adminpage. 
- GetMap und GetFeatureInfo

## REST


