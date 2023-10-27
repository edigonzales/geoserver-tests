<#-- 
Body section of the GetFeatureInfo template, it's provided with one feature collection, and
will be called multiple times if there are various feature collections
-->

<#-- Kann man es generisch machen, damit es im Root-Template ist? Nachteil: es wird immer ausgeführt. 
Wie kann man die Verdoppelung des Codes verhindern? Einmal für die Antwort der Sql-Antwort, einmal für
das normale Templating. 
Kann es sein, dass man es mehr oder weniger zwingend trennen muss? Wenn ich ein Sql-Template an eine Layer 
hänge, will ich ich ganz speziell behandelt haben und ich muss wissen, WELCHEN Layer ich speziell behandeln
muss. Dass kann ich nur, wenn ich weiss, um welchen Layer es sich handelt. -->

<#setting number_format="##0.##">
<#setting locale="en_US">


<#assign LayerInfo=statics['ch.so.agi.geoserver.LayerInfo']>

<#assign responseList = LayerInfo.executeSql("java:comp/env/jdbc/pub", request, environment.GEOSERVER_DATA_DIR, "ch.so.agi.av.fixpunkte.sql")![]>
<#list responseList as responseMap>

  <table class="featureInfo">
    <caption class="featureInfo">ch.so.agi.av.fixpunkte: ${responseMap['t_id']?c}</caption>

    <colgroup>
      <col style="width:40%">
      <col style="width:60%">
    </colgroup>

    <tbody>
      <#assign odd = false>

      <#list responseMap?keys as key>
        <#if odd>
          <tr class="odd">
        <#else>
          <tr>
        </#if>
        <#assign odd = !odd>
          <td>${key}</td>
          <td>
            <#if responseMap[key]??>${responseMap[key]}<#else></#if>
          </td>
        </tr>
      </#list> 
    </tbody>
  </table>
  <br>
</#list>

<br/>

