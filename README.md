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

Link zu Intercapi:
```
http://localhost/geoserver/agi/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&FORMAT=image%2Fpng&TRANSPARENT=true&QUERY_LAYERS=agi%3Amopublic_grundstueck&STYLES&LAYERS=agi%3Amopublic_grundstueck&exceptions=application%2Fvnd.ogc.se_inimage&INFO_FORMAT=text%2Fhtml&FEATURE_COUNT=50&X=50&Y=50&SRS=EPSG%3A2056&WIDTH=101&HEIGHT=101&BBOX=2596123.0371667286%2C1225519.1819063514%2C2596364.021465255%2C1225760.1662048781
```

Im Featuretype kann man bereits vieles konfigurieren:

- Aliasnamen
- Attribute nicht anzeigen
- Berechnungen mit Attributen (z.B. "true" -> "Ja"). Aufpassen bei "null"-Werten (-> Richtungskerbe? Ist das null oder wird false für null gehalten?)
- Neues Attribute, z.B. für Objektblatt (dynamische Werte werden in den Templates berechnet). Oder aber man kann direkt im Featuretype auf Werte zurückgreifen (Link zu Intercapi).
- Raster: Hier wird es bissle frickliger. Man könnte mit Rastertemplates arbeiten resp. man muss ColorMaps verwendend und dann mit dem Custom Name arbeiten. Oder man missbraucht den Bandnamen (der aber keine Leerzeichen und Sonderzeichen erlaubt).

Templates für HTML- und JSON-Output sorgen für den Rest. 

Datumformatierung scheint mir viele Stellschrauben zu haben. Wahrscheinlich einfacher/robuster, wenn es beim Featuretype passiert. Da kann weiss man ja was man hat (Timestamp, nur Datum, ...).

Idee Custom Layerinfo: Statischer Methodenaufruf im GeoJson-Template. Die Methode liefert html und map mit Werten zurück. Dann kann immer gewählt werden, ob html oder die Werte vom Web GIS Client gerendert werden. Die Werte sind in den Standard-Properties. Das html ist escaped in einem Root-Feld (wie der Titel).

Eventuell kann man auch noch Makros o.ä. schreiben, damit man z.B. für Custom Templates nicht immer den Click-Punkt berechnen muss (wenn man ihn braucht).

Verbesserung Geoserver:
- Reihenfolge ändern (drag n drop)
- Nicht löschen, sondern disablen


**todo** JSON


Aus SIMI:
```
<table class="attribute-list">
    <tbody>
        {% set count_rrb = namespace(count = 0) %}
        {% for dokument in feature.dokumente %}
            {% if dokument.Titel == 'Regierungsratsbeschluss' %}
                {% set count_rrb.count = count_rrb.count + 1 %}
            {% endif %}
        {% endfor %}
        {% set count_rrb_2 = count_rrb.count * 2 %}
        
        {% set publiziertAb_list = feature.publiziertab.split('-') %}
	    <tr>
            <td class="identify-attr-title wrap"><i>Typ-Bezeichnung:</i></td>
            <td class="identify-attr-value wrap">{{ feature.typ_bezeichnung }} </td>
        </tr>
        <tr>
            <td class="identify-attr-title wrap"><i>In Kraft:</i></td>
            <td class="identify-attr-value wrap">{{ feature.publiziertab }}</td>
        </tr>
        {% for dokument in feature.dokumente %}
            {% if dokument.Titel != 'Regierungsratsbeschluss' %}
                <tr>
                    <td class="identify-attr-title wrap"><i>{{ dokument.Titel }}:</i></td>
                    {% if dokument.Titel is none %}
                        <td class="identify-attr-value wrap" style="padding-left: 0;padding-right: 0.25em;"><a href={{ dokument.TextimWeb }} target="_blank">{{ dokument.Titel }}</a></td> 
                    {% else %}
                        <td class="identify-attr-value wrap" style="padding-left: 0;padding-right: 0.25em;"><a href={{ dokument.TextimWeb }} target="_blank">{{ dokument.OffiziellerTitel }}</a></td>
                    {% endif %}
                </tr>
            {% endif %}
        {% endfor %}
        {% if feature.typ_bezeichnung != 'Wald' %}
        <tr>
            <td class="identify-attr-title wrap" rowspan={{ count_rrb_2 }}><i>Regierungsratsbeschluss:</i></td>
            {% for dokument in feature.dokumente %}
                {% if dokument.Titel == 'Regierungsratsbeschluss' %}
                    {% set publiziertAb_list = dokument.publiziertAb.split('-') %}
                        <td class="identify-attr-value wrap" style="padding-left: 0;padding-right: 0.25em;"><a href={{ dokument.TextimWeb }} target="_blank">RRB {{ dokument.OffizielleNr }}</a> vom {{ publiziertAb_list[2] }}.{{publiziertAb_list[1] }}.{{ publiziertAb_list[0] }} <br>{{ dokument.OffiziellerTitel }}</td>
                    </tr>
                    <tr>
                {% endif %}
            {% endfor %}
        </tr>
        {% endif %}
    </tbody>
</table>
```

EWS:
```
{% macro formatBool(val) -%}
  {% if val is true %}
      {{ 'Ja' }}
  {% elif val is false %}
      {{ 'Nein' }}
  {% endif %}
{%- endmacro %}
{% macro formatArray(val) -%}
  {% for row in val %}
    {{ row }} </br>
  {% endfor %}
{%- endmacro %}
{% macro formatNull(val) -%}
  {% if val %}
    {{ val }} </br>
  {% endif %}
{%- endmacro %}
<table class="attribute-list">
  <tbody>
    <tr>
      <td class="identify-attr-title wrap"><i>Bohrung erlaubt:</i></td>
      <td class="identify-attr-title wrap">{{ formatBool(feature.permitted) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Bohrtiefe:</i></td>
      <td class="identify-attr-title wrap">{{ formatNull(feature.depth) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Koordinaten:</i></td>
      <td class="identify-attr-title wrap">{{ feature.x }} / {{ feature.y }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Gewässcherschutz betroffen:</i></td>
      <td class="identify-attr-title wrap">{{ formatBool(feature.gwsZone) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Grundwasservorkommen:</i></td>
      <td class="identify-attr-title wrap">{{ formatBool(feature.gwPresent) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Quellen:</i></td>
      <td class="identify-attr-title wrap">{{ formatBool(feature.spring) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Gewaesserraum:</i></td>
      <td class="identify-attr-title wrap">{{ formatBool(feature.gwRoom) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Belasteter Standort:</i></td>
      <td class="identify-attr-title wrap">{{ formatBool(feature.wasteSite) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Rutschung:</i></td>
      <td class="identify-attr-title wrap">{{ formatBool(feature.landslide) }}</td>
    </tr>
    <tr>
      <td class="identify-attr-title wrap"><i>Detailinformationen:</i></td>
      <td class="identify-attr-title wrap">{{ formatArray(feature.infoTextRows) }}</td>
    </tr>
  </tbody>
</table>
```


## Zeilen filtern


## Namespaces
- Was geht ganz ohne?


## REST

