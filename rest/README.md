Idee: Lokal kann  man GUI verwenden, um am Ende das XML herunterzuladen. Dann gibt es ein sehr einfaches config-file, die den curl-Befehlen entsprechen. Achtung: Reihenfolge muss passen, da z.B. sld vorhanden sein muss. (oder template).



```
curl --user admin:geoserver -X GET http://localhost/geoserver/rest/workspaces/cite/featuretypes -H  "accept: application/xml" -H  "content-type: application/json"
```

```
curl --user admin:geoserver -X GET http://localhost/geoserver/rest/workspaces/cite/featuretypes/ch.so.afu.abbaustellen.xml -H  "accept: application/json" -H  "content-type: application/json"
```

```
curl --user admin:geoserver -X POST http://localhost/geoserver/rest/workspaces/cite/datastores/afu_abbaustellen_pub/featuretypes -H  "accept: application/json" -H  "content-type: application/xml" -d "<featureType>
  <name>fuuuubaaar</name>
  <nativeName>abbaustelle</nativeName>
  <namespace>
    <name>cite</name>
    <atom:link xmlns:atom=\"http://www.w3.org/2005/Atom\" rel=\"alternate\" href=\"http://localhost/geoserver/rest/namespaces/cite.xml\" type=\"application/xml\"/>
  </namespace>
  <title>Abbaustellen</title>
  <abstract>Der Layer umfasst die Flächenobjekte der Abbaugebiete, Kleinabbaustellen und künftigen Standorte. Er enthält u.a. Angaben zum abgebauten Material und zur Abstimmungskategorie im Richtplan.</abstract>
  <keywords>
    <string>features</string>
    <string>abbaustelle</string>
  </keywords>
  <nativeCRS class=\"projected\">PROJCS[&quot;CH1903+ / LV95&quot;, 
  GEOGCS[&quot;CH1903+&quot;, 
    DATUM[&quot;CH1903+&quot;, 
      SPHEROID[&quot;Bessel 1841&quot;, 6377397.155, 299.1528128, AUTHORITY[&quot;EPSG&quot;,&quot;7004&quot;]], 
      TOWGS84[674.374, 15.056, 405.346, 0.0, 0.0, 0.0, 0.0], 
      AUTHORITY[&quot;EPSG&quot;,&quot;6150&quot;]], 
    PRIMEM[&quot;Greenwich&quot;, 0.0, AUTHORITY[&quot;EPSG&quot;,&quot;8901&quot;]], 
    UNIT[&quot;degree&quot;, 0.017453292519943295], 
    AXIS[&quot;Geodetic longitude&quot;, EAST], 
    AXIS[&quot;Geodetic latitude&quot;, NORTH], 
    AUTHORITY[&quot;EPSG&quot;,&quot;4150&quot;]], 
  PROJECTION[&quot;Oblique_Mercator&quot;, AUTHORITY[&quot;EPSG&quot;,&quot;9815&quot;]], 
  PARAMETER[&quot;longitude_of_center&quot;, 7.439583333333333], 
  PARAMETER[&quot;latitude_of_center&quot;, 46.952405555555565], 
  PARAMETER[&quot;azimuth&quot;, 90.0], 
  PARAMETER[&quot;scale_factor&quot;, 1.0], 
  PARAMETER[&quot;false_easting&quot;, 2600000.0], 
  PARAMETER[&quot;false_northing&quot;, 1200000.0], 
  PARAMETER[&quot;rectified_grid_angle&quot;, 90.0], 
  UNIT[&quot;m&quot;, 1.0], 
  AXIS[&quot;Easting&quot;, EAST], 
  AXIS[&quot;Northing&quot;, NORTH], 
  AUTHORITY[&quot;EPSG&quot;,&quot;2056&quot;]]</nativeCRS>
  <srs>EPSG:2056</srs>
  <nativeBoundingBox>
    <minx>2593568.0</minx>
    <maxx>2642901.0</maxx>
    <miny>1215050.125</miny>
    <maxy>1257337.25</maxy>
    <crs class=\"projected\">EPSG:2056</crs>
  </nativeBoundingBox>
  <latLonBoundingBox>
    <minx>7.35331152637994</minx>
    <maxx>8.00763176202658</maxx>
    <miny>47.085073887475225</miny>
    <maxy>47.466808757400926</maxy>
    <crs>EPSG:4326</crs>
  </latLonBoundingBox>
  <projectionPolicy>FORCE_DECLARED</projectionPolicy>
  <enabled>true</enabled>
  <metadata>
    <entry key=\"cachingEnabled\">false</entry>
  </metadata>
  <store class=\"dataStore\">
    <name>cite:afu_abbaustellen_pub</name>
    <atom:link xmlns:atom=\"http://www.w3.org/2005/Atom\" rel=\"alternate\" href=\"http://localhost/geoserver/rest/workspaces/cite/datastores/afu_abbaustellen_pub.xml\" type=\"application/xml\"/>
  </store>
  <serviceConfiguration>false</serviceConfiguration>
  <simpleConversionEnabled>false</simpleConversionEnabled>
  <internationalTitle/>
  <internationalAbstract/>
  <maxFeatures>0</maxFeatures>
  <numDecimals>0</numDecimals>
  <padWithZeros>false</padWithZeros>
  <forcedDecimal>false</forcedDecimal>
  <overridingServiceSRS>false</overridingServiceSRS>
  <skipNumberMatched>false</skipNumberMatched>
  <circularArcPresent>false</circularArcPresent>
  <attributes>
    <attribute>
      <name>t_ili_tid</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.util.UUID</binding>
    </attribute>
    <attribute>
      <name>mpoly</name>
      <minOccurs>1</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>false</nillable>
      <binding>org.locationtech.jts.geom.MultiPolygon</binding>
    </attribute>
    <attribute>
      <name>Bezeichnung</name>
      <minOccurs>1</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>false</nillable>
      <binding>java.lang.String</binding>
      <source>bezeichnung</source>
    </attribute>
    <attribute>
      <name>Fubaaaaar</name>
      <minOccurs>1</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>false</nillable>
      <binding>java.lang.String</binding>
      <source>aktennummer</source>
    </attribute>
    <attribute>
      <name>gemeinde_name</name>
      <minOccurs>1</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>false</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>gemeinde_bfs</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.Integer</binding>
    </attribute>
    <attribute>
      <name>art_txt</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>stand_txt</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>rohstoffart</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>rohstoffart_txt</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>gestaltungsplanvorhanden</name>
      <minOccurs>1</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>false</nillable>
      <binding>java.lang.Boolean</binding>
    </attribute>
    <attribute>
      <name>gestaltungsplanvorhanden_txt</name>
      <minOccurs>1</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>false</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>richtplannummer</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>standrichtplan</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>standrichtplan_txt</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>rrb_nr</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.lang.String</binding>
    </attribute>
    <attribute>
      <name>rrb_datum</name>
      <minOccurs>0</minOccurs>
      <maxOccurs>1</maxOccurs>
      <nillable>true</nillable>
      <binding>java.sql.Date</binding>
    </attribute>
  </attributes>
</featureType>"
```
